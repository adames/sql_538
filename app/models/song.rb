class Song

  def self.sql_query
    sql = <<-SQL
    INSERT INTO songs (title, release_date)
    VALUES (?, ?)
    SQL
  end

  def self.get_formatted_text(value)
    value.to_s.downcase.gsub(/['"]/, "'" => "\''", '"' => '\""')
  end

  def self.get_all_songs
  RECORDS.map do |record|
      [self.get_formatted_text(record[:song]),
      record[:album_release_date],
      record[:id]]
    end.uniq { |values| values.first }
  end

  def self.update_record_hash_with_database_id(sql_id, hash_id)
    RECORDS.each_with_index do |record, index|
      if record[:id] == hash_id
        RECORDS[index][:song_id] = sql_id
      end
    end
  end

  def self.insert_songs_into_db
    self.get_all_songs.each do |value_array|
      DB.execute(self.sql_query, value_array[0..1])
      song_id = DB.execute("SELECT last_insert_rowid()")[0][0]
      self.update_record_hash_with_database_id(song_id, value_array[2])
    end
  end

end
