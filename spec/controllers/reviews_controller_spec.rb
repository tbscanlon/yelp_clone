require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  let!(:kfc) { Restaurant.create(name: "KFC", description: "Worst chicken") }

  describe "GET /new" do
    it "responds with 200" do
      get :new, params: { restaurant_id: kfc.id }
      expect(response).to have_http_status(200)
    end
  end
end
