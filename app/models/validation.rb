class Validation
  include MongoMapper::EmbeddedDocument
  
  key :type, String
  key :key,  String
  
  validates_presence_of  :key
  validates_inclusion_of :type, :within => methods.grep(/^validates_/)
  
  def apply(klass, scope)
    klass.send("validates_#{type}", key)
  end
end