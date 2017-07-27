require 'rails_helper'

feature 'Restaurants' do
  context 'No restaurants have been added' do
    scenario 'displays a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context "Restaurants have been added" do
    before do
      Restaurant.create(name: "KFC")
    end

    scenario "display restaurants" do
      visit '/restaurants'
      expect(page).to have_content 'KFC'
      expect(page).to_not have_content "No restaurants yet"
    end
  end
end
