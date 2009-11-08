class Association
  include MongoMapper::EmbeddedDocument
  
  key :name, String
  key :type, String, :default => 'many'
  
  validates_presence_of  :name, :type
  validates_inclusion_of :type, :within => ['many', 'belongs_to']
  
  def apply(klass, scope)
    klass.send(type, name)
    klass.associations[name].instance_variable_set("@klass", scope.content_type_as_const(name.classify)) # ugly hack until jnunemaker merges my changes
    if type.to_sym == :belongs_to
      klass.key name.foreign_key, String
    end
  end
end