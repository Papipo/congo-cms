class Key
  include MongoMapper::EmbeddedDocument
  
  key :name, String
  key :type, String, :default => 'String'
end