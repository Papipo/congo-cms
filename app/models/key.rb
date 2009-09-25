class Key
  include MongoMapper::EmbeddedDocument
  
  key :name, String
  key :type, String, :default => 'String'
  
  validates_presence_of :name, :type
  
  def to_code
    "key :#{name}, Congo::Types::#{type.to_s}"
  end
end