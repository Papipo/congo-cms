class Product
  include MongoMapper::Document
  
  key :name, String
  key :description, String
  key :price, Price
  key :tags, Array
end