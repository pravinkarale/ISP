class Api::ProvidersController < ApplicationController

  def index
    providers = Provider.search_by(params[:search_by_column], params[:search_by_val]).order_by(params[:order_by_column], params[:order_by_val])
    render json: {message: 'success', providers: providers}
  end

  def show
    provider = Provider.find_by(id: params[:id])
    response = if provider.present?
      {message: 'success', provider: provider}
    else
      {message: 'failure'}
    end
    render json: response
  end

  def create
    provider = Provider.new(provider_params)
    if provider.save
      success_message = 'Internet service provider created successfully'
      render json: { result: "success", status: "success", message: success_message, provider: provider }
    else
      error_message = 'Please fill up all mandatory fields with valid format'
      render json: { result: "failure", status: "failure", message: error_message }
    end
  end

  def provider_params
    params.require(:provider).permit(:name, :lowest_price, :rating, :max_speed, :description, :contact_no, :email, :image_name, :image_path, :url)
  end
end
