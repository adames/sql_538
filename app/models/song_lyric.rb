class SongLyric

  def self.sql_insert_query
    sql = <<-SQL
    INSERT INTO songs_lyrics (song_id, lyric_id)
    VALUES (?, ?)
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

  def self.get_all_records
    RECORDS.map do |record|
    end
  end

  def self.insert_songs_into_db
    self.get_all_songs.each do |value_array|
      DB.execute(self.sql_query, value_array)
    end
  end

end
