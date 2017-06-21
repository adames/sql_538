class Lyric

  def self.sql_query
    sql = <<-SQL
    INSERT INTO lyrics (line, sentiment, theme)
    VALUES (?, ?, ?)
    SQL
  end

  def self.get_formatted_text(value)
    value.downcase.gsub(/['"]/, "'" => "\''", '"' => '\""')
  end

  def self.get_all_lyrics
    RECORDS.map do |record|
      [self.get_formatted_text(record[:line]),
      self.get_formatted_text(record[:sentiment]),
      self.get_formatted_text(record[:theme]),
      record[:id]]
    end.uniq
  end

  def self.update_record_hash_with_database_id(lyric_id)
    RECORDS.each_with_index do |record, index|
      if record[:id] == @@id
        RECORDS[index][:lyric_id] = lyric_id
      end
    end
  end

  def self.insert_lyrics_into_db
    self.get_all_lyrics.each do |value_array|
      DB.execute(self.sql_query, value_array)
      lyric_id = DB.execute("SELECT last_insert_rowid()")[0][0]
      self.update_record_hash_with_database_id(lyric_id)
      binding.pry
    end
  end

  # def self.create_songs_lyrics_table_record
  #   lyric_id =
  #   binding.pry
  # end

end
