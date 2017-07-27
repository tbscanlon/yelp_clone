require 'rails_helper'

RSpec.describe RestaurantsController, type: :controller do
  describe "GET /" do
    it "responds with 200" do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /new" do
    it "responds with 200" do
      get :new
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /" do
    before do
      post :create, params: { restaurant: { name: "KFC" } }
    end

    it "responds with 200" do
      expect(response).to redirect_to(restaurants_url)
    end

    it "creates a new restaurant entry" do
      expect(Restaurant.find_by(name: "KFC")).to be
    end
  end

  describe "GET /:id" do
    let!(:kfc) { Restaurant.create(name: "KFC") }

    it "responds with 200" do
      get :show, params: { id: kfc.id }
      expect(response).to have_http_status(200)
    end
  end
end
