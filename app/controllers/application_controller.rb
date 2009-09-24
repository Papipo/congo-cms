# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  rescue_from MongoMapper::DocumentNotFound, :with => :not_found
  rescue_from ArgumentError, :with => :bad_request
  
  private
  def not_found
    respond_to do |format|
      format.json { head :not_found }
    end
  end
  
  def bad_request
    respond_to do |format|
      format.json { head :bad_request }
    end
  end
end
