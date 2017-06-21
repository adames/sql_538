class Song

  def self.sql_insert_query
    sql = <<-SQL
    INSERT INTO songs (title, release_date, artist_id, candidate_id)
    VALUES (?, ?, ?, ?)
    SQL
  end

  def self.sql_select_query(table)
    sql = <<-SQL
    SELECT id FROM #{table} WHERE name = ?
    SQL
  end

  def self.get_formatted_text(value)
    value.to_s.downcase.gsub(/['"]/, "'" => "\''", '"' => '\""')
  end

  def self.get_all_songs
  RECORDS.map do |record|
      [self.get_formatted_text(record[:song]),
      record[:album_release_date],
      self.get_formatted_text(record[:candidate]),
      self.get_formatted_text(record[:artist])]
    end.uniq { |values| values.first }
  end

  def self.insert_songs_into_db
    self.get_all_songs.each do |value_array|
      candidate_id = DB.execute(self.sql_select_query("candidates"),value_array[2])
      artist_id = DB.execute(self.sql_select_query("artists"),value_array[3])
      DB.execute(self.sql_insert_query, value_array[0], value_array[1], artist_id, candidate_id)
    end
  end

end
