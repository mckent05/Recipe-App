class PublicRecipiesController < ApplicationController

	def index
		@public_recipies = Recipe.where(public: true)
	end
end
