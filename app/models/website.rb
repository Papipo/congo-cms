class Website
  include MongoMapper::Document
  include Congo::TypeScoper

  key :name, String
  many :domains
  many :sections
  many :templates
end