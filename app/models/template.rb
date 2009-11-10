class Template
  include MongoMapper::Document
  
  key :content, String
  
  belongs_to :website
  key :website_id
  
  def render
    context.content = nil
    parser.parse(content)
  end
  
  def render_with_content(inner_content)
    context.content = inner_content
    parser.parse(content)
  end
  
  private
  def parser
    @parser ||= Radius::Parser.new(context, :tag_prefix => 'r')
  end
  
  def context
    @context ||= Congo::WebsiteContext.new(website)
  end
end