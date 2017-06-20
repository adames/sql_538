class Artist

  def self.sql_query(values)
    sql = <<-SQL
    INSERT INTO artists (name)
    VALUES ('#{values}')
    SQL
  end

  def self.get_all_artists
    data = PortCsv.new
    data.get_records.map do |record|
      record[:artist].downcase
    end.uniq
  end

  def self.insert_artists_into_db
    self.get_all_artists.each do |artist|
      binding.pry
      DB.execute(self.sql_query(artist))
    end
  end

end
