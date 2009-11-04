class Section
  include MongoMapper::Document
  
  key :path, String
  many :templates
  
  belongs_to :website
  key :website_id, String
  validates_presence_of :website_id
  
  belongs_to :custom_type
  key :custom_type_id
  validate :validate_custom_type
  
  def custom_type_as_const
    @custom_type_as_const ||= website.custom_type_as_const(custom_type.name)
  end
  
  private
  def validate_custom_type
    errors.add(:custom_type, "can't be an embedded one") if custom_type.embedded?
    errors.add(:custom_type, "must belong to the section website") unless website.custom_types.include?(custom_type)
  end
end