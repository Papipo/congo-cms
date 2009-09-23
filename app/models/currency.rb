class Currency
  include MongoMapper::EmbeddedDocument
  
  key :name, String
  key :code, String
  key :symbol, String
  key :format, String
end