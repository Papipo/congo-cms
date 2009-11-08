class SiteController < ApplicationController
  def show
    render :text => current_template.render
  end
  
  private
  def current_template
    current_section.templates.find(:first, :name => params[:template_name])
  end
  
  def current_section
    @current_section ||= current_website.sections.find(:first, :path => params[:section_path])
  end
end