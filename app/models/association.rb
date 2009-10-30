class Association
  include MongoMapper::EmbeddedDocument
  
  key :name, String
  key :type, String, :default => 'many'
  
  validates_presence_of  :name, :type
  validates_inclusion_of :type, :within => ['many']
  
  def apply(klass, scope)
    klass.send(type, name)
    klass.associations[name].instance_variable_set("@klass", scope.custom_type_as_const(name.classify)) # ugly hack until jnunemaker merges my changes
  end
end