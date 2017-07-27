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

  context "Creating Restaurants" do
    scenario "prompts user to fill out a form, then displays the new restaurant" do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: "KFC"
      click_button 'Create Restaurant'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq '/restaurants'
    end
  end

  context "Viewing Restaurants" do
    let!(:kfc) { Restaurant.create(name: "KFC") }

    scenario "lets a user view a restaurant" do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end

  context "Editing restaurants" do
    before { Restaurant.create name: "KFC", description: "Deep fried goodness", id: 1 }

    scenario "Let a user edit a restaurant" do
      visit '/restaurants'
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      fill_in 'Description', with: 'Deep fried goodness'
      click_button 'Update Restaurant'
      click_link 'Kentucky Fried Chicken'
      expect(page).to have_content 'Kentucky Fried Chicken'
      expect(page).to have_content 'Deep fried goodness'
      expect(current_path).to eq '/restaurants/1'
    end
  end

  context "Deleting restaurants" do
    before { Restaurant.create name: "KFC", description: "Deep fried goodness" }

    scenario "Removes a restaurant when a user clicks a delete link" do
      visit '/restaurants'
      click_link 'Delete KFC'
      expect(page).to_not have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted successfully'
    end
  end
end
