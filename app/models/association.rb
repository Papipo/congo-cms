class Association
  include MongoMapper::EmbeddedDocument
  
  key :name, String
  key :type, String, :default => 'many'
  
  validates_presence_of  :name, :type
  validates_inclusion_of :type, :within => ['many']
  
  def to_code
    "#{type} :#{name}, :class_name => 'Congo::Types::#{name.classify}'"
  end
end