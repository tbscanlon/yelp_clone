require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  let!(:kfc) { Restaurant.create(name: "KFC", description: "Worst chicken") }

  describe "GET /new" do
    it "responds with 200" do
      get :new, params: { restaurant_id: kfc.id }
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /" do
    before { post :create, params: { review: { thoughts: "ok", rating: "3" },
    restaurant_id: kfc.id } }

    it "redirects to restaurant" do
      expect(response).to redirect_to(restaurants_path)
    end

    it "creates a review" do
      expect(Review.find_by(thoughts: "ok")).to be
    end
  end
end
