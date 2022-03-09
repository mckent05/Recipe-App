require 'rails_helper'

RSpec.describe 'Post Index page', type: :feature do
  describe 'Post Index requirements' do
    before(:each) do
      User.create(
        name: 'akinlade temitope',
        id: 1,
        email: 'topea@yahoo.com',
        password: '123456',
        confirmed_at: Time.now,
      )

      users = User.all
      Recipe.create(user:users[0], name: 'spaghetti recipe', description: 'cooking a meal', preparation_time: '1.5 hours', cooking_time: '1 hour', public: true )
      Recipe.create(user:users[0], name: 'Rice recipe', description: 'cooking rice', preparation_time: '1 hour', cooking_time: '2 hour', public: true )
      visit new_user_session_path
      fill_in 'user_email', with: 'topea@yahoo.com'
      fill_in 'user_password', with: '123456'
      click_button 'Log in'
      visit root_path
    end

    it 'Log In, expect page to have username' do
      user = User.all
      expect(page).to have_content(user[0].name)
    end

    it 'Log In, expect to see foods size' do
        user = User.all
        foods = user[0].foods
        expect(page).to have_content(foods.length)
    end

    it 'Log In, expect to see recipe size' do
        user = User.all
        recipes = user[0].recipes
        expect(page).to have_content(recipes.length)
    end

    it 'Log In, expect to see View My Recipe Link' do
      click_link 'View My Recipe'
      expect(page).to have_current_path recipies_path
  end
  end
end