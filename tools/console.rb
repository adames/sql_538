require_relative "../config/environment.rb"

records = Artist.get_records_from_csv
pry.start
