module Congo
  module TypeScoper
    def content_type_as_const(name)
      return name.constantize if Object.const_defined?(name)
      unless consts[name]
        consts[name] = content_types.find(:first, :name => name).to_const # This doesn't work because of different instances being used
      end
      consts[name]
    end
    
    private
    def self.included(base)
      base.many :content_types, :as => :scope
    end
    
    def consts
      @consts ||= {}
    end

    def method_missing(method, *args)
      if ctype = content_type_as_const(method.to_s.classify)
        metaclass.many method
        metaclass.associations[method].instance_variable_set("@klass", ctype)  # ugly hack until jnunemaker merges my changes
        send(method, *args)
      else
        super
      end
    end
  end
end