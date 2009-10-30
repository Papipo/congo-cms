# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  rescue_from MongoMapper::DocumentNotFound, :with => :not_found
  rescue_from ArgumentError, :with => :bad_request
  rescue_from MongoMapper::DocumentNotValid, :with => :document_not_valid
  
  private
  def not_found
    respond_to do |format|
      format.json { head :not_found }
      format.html { render :file => 'public/404.html' }
    end
  end
  
  def bad_request
    respond_to do |format|
      format.json { head :bad_request }
    end
  end
  
  def document_not_valid(exception)
    respond_to do |format|
      format.json { render :json => {:error => exception.message }, :status => :bad_request }
    end
  end
  
  def current_website
    @website ||= Website.find(:first, 'domains.name' => request.domain)
  end
end
