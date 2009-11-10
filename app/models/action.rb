class Action < Template
  include MongoMapper::Document
  
  belongs_to :section
  key :section_id
  
  private
  def content_type
    @content_type ||= section.content_type_as_const
  end
  
  def context
    @context ||= Congo::ContentTypeContext.new(content_type, section.website)
  end
end