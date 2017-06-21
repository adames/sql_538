class Lyric

  def self.sql_insert_query
    sql = <<-SQL
    INSERT INTO lyrics (line, sentiment, theme)
    VALUES (?, ?, ?)
    SQL
  end

  def self.sql_select_query(table)
    sql = <<-SQL
    SELECT id FROM #{table} WHERE title = ?
    SQL
  end

  def self.get_formatted_text(value)
    value.to_s.downcase.gsub(/['"]/, "'" => "\''", '"' => '\""')
  end

  def self.get_all_lyrics
    RECORDS.map do |record|
      [self.get_formatted_text(record[:line]),
      self.get_formatted_text(record[:sentiment]),
      self.get_formatted_text(record[:theme]),
      self.get_formatted_text(record[:song])]
    end.uniq  { |values| values.first }
  end

  def self.create_songs_lyrics_table_record(song_id, lyric_id)
    DB.execute("INSERT INTO songs_lyrics (song_id, lyric_id) VALUES (#{song_id}, #{lyric_id})")
  end

  def self.insert_lyrics_into_db
    self.get_all_lyrics.each do |value_array|
      DB.execute(self.sql_insert_query, value_array[0..2])
      lyric_id = DB.execute("SELECT last_insert_rowid()")[0][0]
      song_id = DB.execute(self.sql_select_query("songs"),value_array[3])[0][0]
      create_songs_lyrics_table_record(song_id, lyric_id)
    end
  end

end
