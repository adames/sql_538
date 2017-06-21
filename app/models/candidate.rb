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
      [self.get_formatted_candidates_name(record),
      record[:id]]
    end.uniq
  end

  def self.update_record_hash_with_database_id(sql_id, hash_id)
    RECORDS.each_with_index do |record, index|
      if record[:id] == hash_id
        RECORDS[index][:candidate_id] = sql_id
      end
    end
  end

  def self.insert_candidates_into_db
    self.get_all_candidates.each do |value_array|
      DB.execute(self.sql_query(value_array[0]))
      candidate_id = DB.execute("SELECT last_insert_rowid()")[0][0]
      self.update_record_hash_with_database_id(candidate_id, value_array[1])
    end
  end

end
