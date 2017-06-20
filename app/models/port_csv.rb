class PortCsv
  attr_reader :records

  def initialize(filepath="./genius_hip_hop_lyrics.csv")
      @filepath = filepath
  end

  def read
    CSV.read(@filepath, {:headers => true, :header_converters => :symbol, :converters => :all})
  end

  def get_records
    csv = read
    parsed_csv = csv.to_a.map {|row| {
                          id: row[0],
                          candidate: row[1],
                          song: row[2],
                          artist: row[3],
                          sentiment: row[4],
                          theme: row[5],
                          album_release_date: row[6],
                          line: row[7]
                        }}
    parsed_csv.shift
    @records = parsed_csv
  end

end
