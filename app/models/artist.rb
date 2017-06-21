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
      self.get_formatted_artist_name(record)
    end.uniq
  end

  def self.insert_artists_into_db
    self.get_all_artists.each do |artist|
      DB.execute(self.sql_query(artist))
    end
  end

end
