module Congo
  class ContentTypeContext < WebsiteContext
    def initialize(content_type, website)
      super(website)
      
      globals.collection = content_type
      
      define_tag(:current_type) do |tag|
        tag.locals.collection = content_type
        tag.expand
      end
      
      define_tag(:all) do |tag|
        tag.locals.collection.all.inject('') do |memo,record|
          tag.locals.record = record
          memo + tag.expand
        end
      end
      
      define_tag(:first) do |tag|
        tag.locals.record = tag.locals.collection.first
        tag.expand
      end
    end
    
    private
    def tag_missing(name, attributes, &block)
      if is_key?(name)
        key(name)
      elsif is_association?(name)
        association(name, attributes, &block)
      else
        super
      end
    end
    
    def is_association?(name)
      current_binding.locals.record.class.associations.include?(name) rescue false
    end
    
    def is_key?(name)
      current_binding.locals.record.class.keys.include?(name) rescue false
    end
    
    def key(name)
      current_binding.locals.record.send(name)
    end
    
    def association_type(name)
      current_binding.locals.record.class.associations[name].type
    end
    
    def current_binding
      @tag_binding_stack.last
    end
    
    def association(name, attributes, &block)
      new_binding = Radius::TagBinding.new(current_binding.context, current_binding.locals, name, attributes, block)
      case association_type(name)
      when :many
        new_binding.locals.collection = current_binding.locals.record.send(name)
      when :belongs_to
        new_binding.locals.record = current_binding.locals.record.send(name)
      end
      @tag_binding_stack.push(new_binding)
      new_binding.expand
    end
  end
end