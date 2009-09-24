class DynamicType
  include MongoMapper::Document
  
  key :embedded, Boolean, :default => true
  many :keys, :class_name => 'Key'
end