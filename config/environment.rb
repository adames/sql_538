require 'csv'
require 'json'
require 'pry'
require 'sqlite3'
require_relative "../app/models/port_csv.rb"
require_relative "../app/models/candidate.rb"
require_relative "../app/models/artist.rb"
require_relative "../app/models/lyric.rb"
require_relative "../app/models/song.rb"
require_relative "../app/models/tables.rb"
require_relative "../app/services/queries.rb"

DB ||= SQLite3::Database.new("db/lyrics.db")
RECORDS ||= PortCsv.new.get_records
