class Artist

  def self.get_records_from_csv
    data = PortCsv.new
    data.get_records
  end

  def self.insert_artists_into_db
    sql = <<-SQL
    INSERT INTO artists (name)
    VALUES ('')
    SQL

    # DB.execute(sql)
  end

end
