class RecipiesController < ApplicationController
  def index
    @recipes = current_user.recipes
  end

  def create
   new_recipe = current_user.recipes.new(recipe_params)
   respond_to do |format|
    format.html do
      if new_recipe.save
        flash[:success] = 'New Recipe Added Succesfully!'
        redirect_to recipies_path
      else
        render :new, alert: 'Error occured!'
      end
    end
  end
  end


  def destroy
    recipe = Recipe.find(params[:id])
    recipe.destroy
    redirect_to recipies_path
    flash[:success] = 'Recipe Deleted!'

  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end


  private

  def recipe_params
    params.require(:data).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end

  def new; end
end


