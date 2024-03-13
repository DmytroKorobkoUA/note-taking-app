require 'mongo'

Mongo::Logger.logger = Rails.logger

mongodb_client = Mongo::Client.new('mongodb://superuser:superuser@localhost:27017/notes_development')
MONGODB_COLLECTION = mongodb_client[:request_logs]