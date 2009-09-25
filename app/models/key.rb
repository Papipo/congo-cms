class Key
  include MongoMapper::EmbeddedDocument
  
  key :name, String
  key :type, String, :default => 'String'
  
  def to_code
    "key :#{name}, Congo::Types::#{type.to_s}"
  end
end