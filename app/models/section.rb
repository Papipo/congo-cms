class Section
  include MongoMapper::Document
  
  key :path, String
  many :actions
  
  belongs_to :website
  key :website_id, String
  validates_presence_of :website_id
  
  belongs_to :content_type
  key :content_type_id
  validate :validate_content_type
  
  def content_type_as_const
    @content_type_as_const ||= website.content_type_as_const(content_type.name)
  end
  
  private
  def validate_content_type
    errors.add(:content_type, "can't be an embedded one") if content_type.embedded?
    errors.add(:content_type, "must belong to the section website") unless website.content_types.include?(content_type)
  end
end