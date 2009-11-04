class Template < Radius::Context
  include MongoMapper::Document
  
  key :content, String
  
  belongs_to :section
  key :section_id
  
  def render
    parser.parse(content)
  end
  
  private
  def custom_type
    @custom_type ||= section.custom_type_as_const
  end
  
  def parser
    @parser ||= Radius::Parser.new(context, :tag_prefix => 'r')
  end

  def context
    @context ||= Radius::Context.new do |c|
      c.define_tag :all do |tag|
        custom_type.all.map { |record|
          tag.locals.record = record
          tag.expand
        }.join
      end
      
      custom_type.keys.keys.each do |key|
        c.define_tag key do |tag|
          tag.locals.record.send(key)
        end
      end
    end
  end
end