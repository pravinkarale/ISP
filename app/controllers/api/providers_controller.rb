class Api::ProvidersController < ApplicationController

  # GET /api/providers
  # GET /api/providers.json
  def index
    providers = Provider.search_by(params[:search_by_column], params[:search_by_val]).order_by(params[:order_by_column], params[:order_by_val])
    render json: { status: 'success', message: 'success', providers: providers}
  end

  # GET /api/providers/1
  # GET /api/providers/1.json
  def show
    provider = Provider.find_by(id: params[:id])
    response = if provider.present?
      { status: 'success', message: 'Record found', provider: provider }
    else
      { status: 'failure' , message: 'Record not found' }
    end
    render json: response
  end

  # POST /api/providers
  # POST /api/providers.json
  def create
    provider = Provider.new(provider_params)
    if provider.save
      success_message = 'Internet service provider created successfully'
      render json: { status: "success", message: success_message, provider: provider }
    else
      error_message = 'Please fill up all mandatory fields with valid format'
      render json: { status: "failure", message: error_message }
    end
  end

  private

  def provider_params
    params.require(:provider).permit(:name, :lowest_price, :rating, :max_speed, :description, :contact_no, :email, :url)
  end
end
