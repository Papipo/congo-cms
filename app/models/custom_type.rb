class CustomType
  include MongoMapper::Document
  
  key  :embedded, Boolean, :default => false
  many :keys
  many :validations
  many :associations

  key :scope_type, String
  key :scope_id, String
  belongs_to :scope, :polymorphic => true
  validates_presence_of :scope
  
  def to_const
    klass = Class.new
    if self.embedded?
      klass.class_eval { include MongoMapper::EmbeddedDocument }
    else
      klass.class_eval { include MongoMapper::Document }
      klass.set_collection_name "#{scope_type}_#{scope_id}_#{name.tableize}"
    end
    add_scope(klass)
    apply_metadata(klass)
    klass
  end
  
  private
  def add_scope(klass) # this should be dynamic, based on scope
    klass.class_eval {
      key :website_id, String
      belongs_to :website
      validates_presence_of :website
    }
  end
  
  def apply_metadata(klass)
    %w[keys associations validations].each do |association|
      self.send(association).each { |meta| meta.apply(klass, scope) }
    end
  end
end