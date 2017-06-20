require 'csv'
require 'json'
require 'pry'
require 'sqlite3'
require_relative "../app/models/port_csv.rb"
require_relative "../app/models/candidate.rb"
require_relative "../app/models/artist.rb"

DB ||= SQLite3::Database.new("../db/lyrics.db")
