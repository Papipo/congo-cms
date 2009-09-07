module Congo
  class Database
    
    def self.stablish_connection(config)
      @@db = Mongo::Connection.new(config['host'], config['port']).db(config['database'])
    end
    
    def self.collection(name)
      @@db.collection(name)
    end
  end
end