class Validation
  include MongoMapper::EmbeddedDocument
  
  key :type, String
  key :key,  String
  
  def to_code
    "validates_#{type} :#{key}"
  end
end