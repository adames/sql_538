class Artist

  def self.sql_query(values)
    sql = <<-SQL
    INSERT INTO artists (name)
    VALUES ('#{values}')
    SQL
  end

  def self.get_formatted_artist_name(record)
    record[:artist].downcase.gsub(/['"]/, "'" => "\''", '"' => '\""')
  end

  def self.get_all_artists
    RECORDS.map do |record|
      [self.get_formatted_artist_name(record),
      record[:id]]
    end.uniq  { |values| values.first }
  end

  def self.update_record_hash_with_database_id(sql_id, hash_id)
    RECORDS.each_with_index do |record, index|
      if record[:id] == hash_id
        RECORDS[index][:artist_id] = sql_id
      end
    end
  end

  def self.insert_artists_into_db
    self.get_all_artists.each do |value_array|
      DB.execute(self.sql_query(value_array[0]))
      artist_id = DB.execute("SELECT last_insert_rowid()")[0][0]
      self.update_record_hash_with_database_id(artist_id, value_array[1])
    end
  end

end
