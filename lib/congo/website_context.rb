module Congo
  class WebsiteContext < Radius::Context
    def initialize(website)
      super()
      
      @website = website
      
      define_tag(:render) do |tag|
        raise "render tag expects a \"template\" attribute" if tag['template'].nil?
        template = fetch_template(tag['template'])
        raise "template #{tag['template']} does not exist"  if template.nil?
        tag.single? ? template.render : template.render_with_content(tag.expand)
      end
      
      define_tag(:content) do |tag|
        @content
      end
    end
    
    def content=(content)
      @content = content
    end
    
    private
    def fetch_template(name)
      website.templates.find(:first, :name => name)
    end
    
    def website
      @website
    end
  end
end