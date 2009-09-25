module Congo
  class Types
    MongoMapper::Key::NativeTypes.each { |native_type| const_set(native_type.to_s, Class.new(native_type)) }
    
    private
    def self.const_missing(name)
      if metadata = ::DynamicType.find(name.to_s)
        const_set(name, from_metadata(metadata))
      else
        super
      end
    end
    
    def self.from_metadata(metadata)
      klass = Class.new
      klass.class_eval { include metadata.embedded? ? MongoMapper::EmbeddedDocument : MongoMapper::Document }
      klass.class_eval(metadata.evaluable_keys)
      klass.class_eval(metadata.evaluable_validations)
      klass
    end
  end
end