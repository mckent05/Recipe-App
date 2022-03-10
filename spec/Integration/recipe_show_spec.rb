require 'rails_helper'

RSpec.describe 'Recipe Show page', type: :feature do
  describe 'Recipe Show requirements' do
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
      Food.create(user: users[0], name: 'Spaghetti', price: '100', measurement_unit: 'grams')
      Food.create(user: users[0], name: 'Yam', price: '150', measurement_unit: 'kilograms')
      RecipeFood.create(quantity: '4', recipe: users[0].recipes[0], food: users[0].foods[0])
      RecipeFood.create(quantity: '3', recipe: users[0].recipes[0], food: users[0].foods[1])
      recipes = users[0].recipes
      recipe_name = recipes[0].name
      visit new_user_session_path
      fill_in 'user_email', with: 'topea@yahoo.com'
      fill_in 'user_password', with: '123456'
      click_button 'Log in'
      visit root_path
      click_on 'View All Recipes'
      visit recipies_path
      click_on recipe_name
      visit recipy_path(recipes[0].id)
    end

    it 'Expect show page to have recipe name' do
      users = User.all
      recipes = users[0].recipes
      expect(page).to have_content(recipes[0].name)
    end

    it 'Expect show page to have recipe preparation time' do
      users = User.all
      recipes = users[0].recipes
      expect(page).to have_content(recipes[0].preparation_time)
    end

    it 'Expect show page to have recipe cooking time' do
      users = User.all
      recipes = users[0].recipes
      expect(page).to have_content(recipes[0].cooking_time)
    end

    it 'Expect show page to have recipe description' do
      users = User.all
      recipes = users[0].recipes
      expect(page).to have_content(recipes[0].description)
    end

    it 'Expect show page to have Generate shopping list link' do
      expect(page).to have_content('Generate Shopping List')
    end

    it 'Expect show page to have Add new Ingredients' do
      expect(page).to have_content('Generate Shopping List')
    end

    it 'Expect to have current path after clicking on Generate Shopping List link' do
      click_on 'Generate Shopping List'
      expect(page).to have_current_path generate_shopping_list_index_path
    end

    it 'Expect to have current path after clicking on Add new Ingredients' do
      users = User.all
      recipes = users[0].recipes
      click_on 'Add new Ingredients'
      expect(page).to have_current_path new_recipy_recipies_food_path(recipes[0].id)
    end

    it 'Expect to have ingredients, food name' do
      users = User.all
      recipes = users[0].recipes
      recipe_foods = recipes[0].recipe_foods
      recipe_foods.each do |recipe_food|
        expect(page).to have_content(recipe_food.food.name)
      end
    end

    it 'Expect to have ingredients, food measurement unit' do
      users = User.all
      recipes = users[0].recipes
      recipe_foods = recipes[0].recipe_foods
      recipe_foods.each do |recipe_food|
        expect(page).to have_content("#{recipe_food.quantity}#{recipe_food.food.measurement_unit}")
      end
    end

    it 'Expect to have ingredients, food name' do
      users = User.all
      recipes = users[0].recipes
      recipe_foods = recipes[0].recipe_foods
      recipe_foods.each do |recipe_food|
        expect(page).to have_content("$#{recipe_food.quantity.to_i * recipe_food.food.price.to_i}")
      end
    end
  end
end
