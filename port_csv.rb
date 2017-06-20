require 'csv'
require 'json'
require_relative './marvel-wikia-data.csv'
require_relative './dc-wikia-data.csv'

CSV.parse(data).to_json
