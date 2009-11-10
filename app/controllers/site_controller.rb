class SiteController < ApplicationController
  def show
    render :text => action.render
  end
  
  private
  def action
    current_section.actions.find(:first, :name => params[:action_name])
  end
  
  def current_section
    @current_section ||= current_website.sections.find(:first, :path => params[:section_path])
  end
end