class PublicRecipiesController < ApplicationController
  def index
    @public_recipies = Recipe.where(public: true).order(created_at: :desc)
  end
end
