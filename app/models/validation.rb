class Validation
  include MongoMapper::EmbeddedDocument
  
  key :type, String
  key :key,  String
  
  validates_presence_of  :key
  validates_inclusion_of :type, :within => methods.grep(/^validates_/)
  
  def to_code
    "validates_#{type} :#{key}"
  end
end