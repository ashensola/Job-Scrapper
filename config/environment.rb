
require 'nokogiri'
require 'httparty'
require 'sqlite3'
DB = {:conn => SQLite3::Database.new("../db/favourites.db")}


require_relative '../lib/job_search_engine/mydatabase.rb'
require_relative '../lib/job_search_engine/scrapper.rb'
require_relative '../lib/job_search_engine/cli.rb'
