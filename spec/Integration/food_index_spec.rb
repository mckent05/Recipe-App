require 'rails_helper'

RSpec.describe 'food Index page', type: :feature do
  describe 'food Index requirements' do
    before(:each) do
      User.create(
        name: 'test',
        id: 1,
        email: 'test@yahoo.com',
        password: '123456',
        confirmed_at: Time.now
      )

      @users = User.all
      Food.create(name: 'apple', measurement_unit: 'gram', price: '$4', user_id: 1)
      Food.create(name: 'apple', measurement_unit: 'gram', price: '$4', user_id: 1)
      visit new_user_session_path
      fill_in 'user_email', with: 'test@yahoo.com'
      fill_in 'user_password', with: '123456'
      click_button 'Log in'
      visit root_path
      click_on 'View My Food'
      visit foods_path
    end

    it 'Log In, check if it has name' do
      users = User.all
      foods = users[0].foods
      foods.each do |food|
        expect(page).to have_content(food.name)
      end
    end

    it 'Log In, check if it has measurement_unit' do
      users = User.all
      foods = users[0].foods
      foods.each do |food|
        expect(page).to have_content(food.measurement_unit)
      end
    end

    it 'Log In, check if it has price' do
      users = User.all
      foods = users[0].foods
      foods.each do |food|
        expect(page).to have_content(food.price)
      end
    end
  end
end
