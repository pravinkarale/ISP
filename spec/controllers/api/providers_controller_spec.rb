require 'rails_helper'
require 'pry'

RSpec.describe Api::ProvidersController, type: 'request' do

  # test new provider creation with valid & invalid data
  describe 'POST /api/providers' do
    context "Save Provider with valid/invalid data" do
      let(:valid_params) do
        {
          provider: {
            name: "ION",
            lowest_price: 350,
            rating: 3.5,
            max_speed: 10,
            description: 'One of the oldest internet service provider',
            contact_no: '9892828282',
            email: "ramakant@gmail.com",
            url: "https://customer.i-on.in:9443/"
          }
        }
      end

      let(:invalid_params) do
        {
          provider: {
            name: "BSNL",
            max_speed: 10,
            description: 'One of the oldest internet service provider',
            contact_no: '9892828245',
            email: "shamkant23@gmail.com",
            url: "https://www.windstream.com/"
          }
        }
      end

      it 'provider with valid data' do
        expect { post "/api/providers", params: valid_params }.to change(Provider, :count).by(+1)
        resp = JSON.parse(response.body)
        expect(resp['status']).to eq 'success'
      end

      it 'provider with invalid data' do
        post "/api/providers", params: invalid_params
        resp = JSON.parse(response.body)
        expect(resp['status']).to eq 'failure'
      end
    end

  end

  describe 'GET /api/providers' do
    before(:each) do
      provider1 = FactoryBot.create(:provider, name: 'pravin')
      provider2 = FactoryBot.create(:provider, name: 'ravindra')
      provider3 = FactoryBot.create(:provider, name: 'mahendra')
    end

    # test sorting of providers with lowest_price descending
    it 'Sort provider by lowest price descending' do
      searching_params = {order_by_column: "lowest_price", order_by_val: 'desc' }
      get "/api/providers", params: searching_params
      resp = JSON.parse(response.body)
      price_column = resp['providers'].map{|pro| pro['lowest_price']}

      expect(Provider.all.order_by('lowest_price', 'desc').pluck(:lowest_price)).to eq(price_column)
    end

    # test sorting of providers with rating ascending
    it 'Sort provider by rating ascending' do
      searching_params = {order_by_column: "rating", order_by_val: 'asc' }
      get "/api/providers", params: searching_params
      resp = JSON.parse(response.body)
      # binding.pry
      rating_column = resp['providers'].map{|provider| provider['rating']}

      expect(Provider.all.order_by('rating', 'asc').pluck(:rating)).to eq(rating_column)
    end

    # test searching provider by name
    it 'Search provider by name' do
      searching_params = {search_by_column: "name", search_by_val: 'mahendra' }
      get "/api/providers", params: searching_params
      resp = JSON.parse(response.body)
      # binding.pry
      expect(resp['providers'].size).to eq(1)
    end
  end

  # test provider show page
  describe 'GET /api/providers/:id' do
    before(:each) do
      provider1 = FactoryBot.create(:provider, name: 'pravin')
    end
    it "Show provider details page" do
      get "/api/providers/#{Provider.first.id}"
      resp = JSON.parse(response.body)
      expect(resp.dig('provider','id')).to eq(Provider.first.id)
    end
  end
end
