class Template
  include MongoMapper::Document
  
  key :content, String
  
  belongs_to :section
  key :section_id
  
  def render
    parser.parse(content)
  end
  
  private
  def content_type
    @content_type ||= section.content_type_as_const
  end
  
  def parser
    @parser ||= Radius::Parser.new(context, :tag_prefix => 'r')
  end

  def context
    @context ||= Congo::ContentTypeContext.new(content_type)
  end
end