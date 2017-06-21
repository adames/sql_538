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
      record[:album_release_date]]
    end.uniq
  end

  def self.insert_songs_into_db
    self.get_all_songs.each do |value_array|
      DB.execute(self.sql_query, value_array)
    end
  end

end
