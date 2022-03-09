require 'rails_helper'

RSpec.describe 'Generate Shopping page', type: :feature do
  describe 'Generate Shopping requirements' do
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
      click_on 'View My Recipe'
      visit recipies_path
      click_on recipe_name
      visit recipy_path(recipes[0].id)
      click_on 'Generate Shopping List'
      visit generate_shopping_list_index_path
    end

    it 'Expect show page to have length of recipe_foods' do
      users = User.all
      recipes = users[0].recipes
      length = 0
      recipes.each do |recipe|
        length += recipe.recipe_foods.length
      end
      expect(page).to have_content(length)
    end

    it 'Expect show page to have length of recipe_foods' do
      users = User.all
      recipes = users[0].recipes
      sum = 0
      recipes.each do |recipe|
        recipe.recipe_foods.each do |r_food|
          sum += r_food.food.price.to_i * r_food.quantity.to_i
        end
      end
      expect(page).to have_content(sum)
    end

    it 'Expect show page to have length of recipe_foods' do
      users = User.all
      recipes = users[0].recipes
      recipes.each do |recipe|
        recipe.recipe_foods.each do |r_food|
          expect(page).to have_content(r_food.food.name)
        end
      end
    end

    it 'Expect show page to have length of recipe_foods' do
      users = User.all
      recipes = users[0].recipes
      recipes.each do |recipe|
        recipe.recipe_foods.each do |r_food|
          expect(page).to have_content("#{r_food.quantity}#{r_food.food.measurement_unit}")
        end
      end
    end
    it 'Expect show page to have length of recipe_foods' do
      users = User.all
      recipes = users[0].recipes
      recipes.each do |recipe|
        recipe.recipe_foods.each do |r_food|
          expect(page).to have_content("$#{r_food.quantity.to_i * r_food.food.price.to_i}")
        end
      end
    end
  end
end
