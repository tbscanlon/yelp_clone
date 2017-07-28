require 'rails_helper'

RSpec.describe RestaurantsController, type: :controller do
  let!(:kfc) { Restaurant.create(name: "KFC", description: "Worst chicken") }

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
      post :create, params: { restaurant: { name: "Dirty Burger" } }
    end

    it "responds with 200" do
      expect(response).to redirect_to(restaurants_url)
    end

    it "creates a new restaurant entry" do
      expect(Restaurant.find_by(name: "Dirty Burger")).to be
    end
  end

  describe "GET /:id" do
    it "responds with 200" do
      get :show, params: { id: kfc.id }
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /edit" do
    it "responds with 200" do
      get :edit, params: { id: kfc.id }
      expect(response).to have_http_status(200)
    end
  end

  describe "PUT /update" do
    before { put :update, params: { id: kfc.id, restaurant: { name: "Kentucky Fried Chicken",
             description: "Best chicken" } } }

    it "responds with 200" do
      expect(response).to redirect_to(restaurants_url)
    end

    it "updates a restaurant entry" do
      expect(Restaurant.find_by(name: "Kentucky Fried Chicken")).to be
    end
  end

  describe "DELETE /destroy" do
    before do
      delete :destroy, params: { id: kfc.id }
    end

    it "responds with 200" do
      expect(response).to redirect_to(restaurants_url)
    end

    it "deletes the restaurant" do
      expect(Restaurant.find_by(name: "KFC")).to_not be
    end
  end
end
