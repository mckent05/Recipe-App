class RecipiesFoodsController < ApplicationController
  def create
    recipe = Recipe.find(params[:recipy_id])
    new_recipe = recipe.recipe_foods.new(recipe_food_params)
    respond_to do |format|
      format.html do
        if new_recipe.save
          flash[:success] = 'New Ingrediet Added Succesfully!'
          redirect_to recipy_path(recipe.id)
        else
          render :new, alert: 'Error occured!'
        end
      end
    end
  end

  def destroy
   recipe_food = RecipeFood.find(params[:id])
   recipe = recipe_food.recipe
   recipe_food.destroy
   redirect_to recipy_path(recipe.id)
   flash[:success] = 'Ingredient Deleted'

  end

  def new
    @foods = current_user.foods
  end

  def recipe_food_params
    params.require(:data).permit(:food_id, :quantity)
  end

end
