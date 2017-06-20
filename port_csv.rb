require 'csv'
require 'json'
require 'pry'

filepath = "./genius_hip_hop_lyrics.csv"

def read
  CSV.read(filepath)
end

def open
CSV.open(filepath, 'w') do |csv_object|

    csv_object << row_array
  end
end

pry.start
