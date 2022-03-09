require 'rails_helper'

RSpec.describe 'Login page', type: :feature do
  describe 'Login Page requirements' do
    it 'has username and password inputs, and Log in button' do
      visit new_user_session_path
      expect(page).to have_field('Email')
      expect(page).to have_field('Password')
      expect(page).to have_button('Log in')
    end

    it 'submits without username and password inputs' do
      visit new_user_session_path
      sleep(1)
      fill_in 'user_email', with: ''
      fill_in 'user_password', with: ''
      click_button 'Log in'
      expect(page).to have_content('Invalid Email or password')
    end

    it 'has incorrect email and password' do
      user1 = User.create(
        name: 'akinlade temitope',
        id: 1,
        email: 'topea@yahoo.com',
        password: '123456',
        confirmed_at: Time.now
      )
      visit new_user_session_path
      fill_in 'user_email', with: user1.email
      fill_in 'user_password', with: '123466'
      click_button 'Log in'
      expect(page).to have_content('Invalid Email or password')
    end

    it 'Should sign in to root page' do
      user1 = User.create(
        name: 'akinlade temitope',
        id: 1,
        email: 'topea@yahoo.com',
        password: '123456',
        confirmed_at: Time.now
      )
      visit new_user_session_path
      fill_in 'user_email', with: user1.email
      fill_in 'user_password', with: '123456'
      click_button 'Log in'
      expect(page).to have_content('Signed in successfully.')
      expect(page).to have_current_path root_path
    end
  end
end
