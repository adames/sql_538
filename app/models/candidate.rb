class Candidate

  def self.sql_query(values)
    sql = <<-SQL
    INSERT INTO candidates (name)
    VALUES ('#{values}')
    SQL
  end

  def self.get_formatted_candidates_name(record)
    record[:candidate].downcase.gsub(/['"]/, "'" => "\''", '"' => '\""')
  end

  def self.get_all_candidates
    RECORDS.map do |record|
      self.get_formatted_candidates_name(record)
    end.uniq
  end

  def self.insert_candidates_into_db
    self.get_all_candidates.each do |candidate|
      DB.execute(self.sql_query(candidate))
    end
  end

end
