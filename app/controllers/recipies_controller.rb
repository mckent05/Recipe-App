class RecipiesController < ApplicationController

    def index
      @recipie = Recipe.all
    end

    def create
			recipe = current_user.recipe.new(post_params)
			respond_to do |format|
				format.html do
					if recipe.save
						flash[:success] = 'Created New Recipe Succesfully!'
						redirect_to recipe_path
					else
						render :new, alert: 'Error occured!'
					end
				end
			end
    end

    def destroy
			recipe = Recipe.find([:id])
			recipe.destroy
			redirect_to recipe_path
    end

    def show
      @recipe = Recipe.find([:id])
      @food = @recipe.foods
    end

    def new
      @recipe = Recipe.new  
    end

end
