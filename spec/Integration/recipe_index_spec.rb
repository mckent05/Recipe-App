require 'rails_helper'

RSpec.describe 'Recipe Index page', type: :feature do
  describe 'Recipe Index requirements' do
    before(:each) do
      User.create(
        name: 'akinlade temitope',
        id: 1,
        email: 'topea@yahoo.com',
        password: '123456',
        confirmed_at: Time.now
      )

      users = User.all
      Recipe.create(user: users[0], name: 'spaghetti recipe', description: 'cooking a meal',
                    preparation_time: '1.5 hours', cooking_time: '1 hour', public: true)
      Recipe.create(user: users[0], name: 'Rice recipe', description: 'cooking rice', preparation_time: '1 hour',
                    cooking_time: '2 hour', public: true)
      visit new_user_session_path
      fill_in 'user_email', with: 'topea@yahoo.com'
      fill_in 'user_password', with: '123456'
      click_button 'Log in'
      visit root_path
      click_on 'View My Recipe'
      visit recipies_path
    end

    it 'Log In, click on link to view recipes' do
      users = User.all
      recipes = users[0].recipes
      recipes.each do |recipe|
        expect(page).to have_content(recipe.name)
      end
    end

    it 'Log In, click on link to view recipes' do
      users = User.all
      recipes = users[0].recipes
      recipes.each do |recipe|
        expect(page).to have_content(recipe.description)
      end
    end

    it 'Log In, click on link to view recipes' do
      users = User.all
      recipes = users[0].recipes
      recipe_name = recipes[0].name
      click_on recipe_name
      expect(page).to have_current_path recipy_path(recipes[0].id)
    end
  end
end
