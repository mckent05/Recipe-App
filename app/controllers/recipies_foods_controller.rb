class RecipiesFoodsController < ApplicationController

    def create

    end

    def destroy
      recipe_food = RecipeFood.find([:id])
			recipe = Recipe.find_by(id: recipe_food.recipe_id)
			recipe_food.destroy
			redirect_to recipes_path(recipe_id)
    end

    def new
			@recipe_food = RecipeFood.new  
    end
end
