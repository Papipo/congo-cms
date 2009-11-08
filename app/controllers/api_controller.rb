class ApiController < ApplicationController
  
  def index
    @result = type.paginate(:page => params[:page], :per_page => params[:per_page] || 10)
    respond_to do |format|
      format.json do
        #headers don't affect eTag, so maybe this approach is bad
        headers['Total-pages']   = @result.total_pages.to_s
        headers['Total-entries'] = @result.total_entries.to_s
        headers['Per-page']      = @result.per_page.to_s
        render :json => @result
      end
    end
  end
  
  def show
    @result = type.find(params[:id])
    respond_to do |format|
      format.json { render :json => @result }
    end
  end
  
  def update
    @result = type.find(params[:id])
    @result.attributes = attributes_for_document
    @result.save! # I would prefer to use the one-liner @type.update!(params[:id], attributes_for_document) instead
    respond_to do |format|
      format.json { render :json => @result, :location => api_show_path(collection, @result, :format => 'json') } # Any shortcut for the location thingy?
    end
  end
  
  def destroy
    type.destroy(params[:id])
    respond_to do |format|
      format.json { head :ok }
    end
  end
  
  private
  def type
    @type ||= current_website.content_type_as_const(params[:collection].classify)
  end
  
  def collection
    @collection ||= params[:collection]
  end
  
  def attributes_for_document
    @attributes_for_document ||= params[params[:collection].to_s.singularize]
  end
end