class ProvidersController < ApplicationController

  def index
    sort_by = params[:sort_by]&.rpartition('_') || []
    @current_params = {
      search_by_column: params[:search_by],
      search_by_val: params[:search_by_value],
      order_by_column: sort_by[0],
      order_by_val: sort_by[2],
      sort_by: params[:sort_by]
    }

    url = "#{ENV['API_BASE_URL']}/api/providers.json?#{@current_params.to_query}"
    response = RestClient.get url
    body = JSON.parse(response)
    @providers = body['providers']
    respond_to do |format|
      format.js
      format.html
    end
  end

  def show
    url = "#{ENV['API_BASE_URL']}/api/providers/#{params[:id]}"
    response = RestClient.get url
    body = JSON.parse(response)
    @provider = body['provider']
    respond_to do |format|
      format.html{}
    end
  end

  def home

  end
end
