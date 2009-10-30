module Congo
  module TypeScoper
    def custom_type_as_const(name)
      return name.constantize if Object.const_defined?(name)
      unless consts[name]
        consts[name] = custom_types.find(:first, :name => name).to_const # This doesn't work because of different instances being used
      end
      consts[name]
    end
    
    private
    def self.included(base)
      base.many :custom_types, :as => :scope
    end
    
    def consts
      @consts ||= {}
    end

    def method_missing(method, *args)
      if ctype = custom_type_as_const(method.to_s.classify)
        metaclass.many method
        metaclass.associations[method].instance_variable_set("@klass", ctype)  # ugly hack until jnunemaker merges my changes
        send(method, *args)
      else
        super
      end
    end
  end
end