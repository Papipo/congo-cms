class ApiController < ApplicationController
  
  def index
    @result = type.find(:all)
    respond_to do |format|
      format.json { render :json => @result }
    end
  end
  
  def show
    @result = type.find(params[:id])
    respond_to do |format|
      format.json { render :json => @result }
    end
  end
  
  def update
    @result = type.update(params[:id], attributes_for_document)
    respond_to do |format|
      format.json { render :json => @result, :location => api_show_path(collection, @result, :format => 'json') } # Any shortcut for the location thingy?
    end
  end
  
  private
  def type
    @type ||= params[:collection].classify.constantize
  end
  
  def collection
    @collection ||= params[:collection]
  end
  
  def attributes_for_document
    @attributes_for_document ||= params[params[:collection].to_s.singularize]
  end
end