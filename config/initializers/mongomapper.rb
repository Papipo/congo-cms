cfg = Rails.configuration.database_configuration[RAILS_ENV]
MongoMapper.connection = Mongo::Connection.new(cfg['host'])
MongoMapper.database   = cfg['database']