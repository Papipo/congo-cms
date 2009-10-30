class Key
  include MongoMapper::EmbeddedDocument
  
  key :name, String
  key :type, String, :default => 'String'
  
  validates_presence_of :name, :type
  
  def apply(klass, scope)
    klass.key name.to_sym, scope.custom_type_as_const(type)
  end
end