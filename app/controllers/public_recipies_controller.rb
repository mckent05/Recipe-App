class PublicRecipiesController < ApplicationController
  def index
      @public_recipes = Recipe.where('public= true').order(id: :desc).includes(:user).includes(:recipe_foods).includes(:foods)
  end
end
