Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "users#index"

  resources :users, only: %i[index]
  resources :foods, only: %i[index create destroy new]
  resources :recipies, only: %i[index create destroy new show] do
      resources :recipies_foods, only: %i[create destroy new]
  end
  resources :public_recipies, only: %i[index]
  resources :generate_shopping_list, only: %i[index]
end
