cfg = Rails.configuration.database_configuration[RAILS_ENV]
MongoMapper.connection = XGen::Mongo::Driver::Mongo.new(cfg['host'])
MongoMapper.database   = cfg['database']