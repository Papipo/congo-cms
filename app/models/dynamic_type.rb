class DynamicType
  include MongoMapper::Document
  
  key  :embedded, Boolean, :default => false
  many :keys
  many :validations
    
  def method_missing(method)
    if method.to_s =~ /^evaluable_([a-z]+)$/ && respond_to?($1)
      send($1).map(&:to_code).join("; ")
    else
      super
    end
  end
end