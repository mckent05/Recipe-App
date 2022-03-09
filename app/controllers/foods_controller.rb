class FoodsController < ApplicationController
  def index
    @food = Food.all
  end

  def new
    @food = Food.new
  end

  def create
    food = current_user.food.new(post_params)
    respond_to do |format|
      format.html do
        if food.save
          flash[:success] = 'Created New Food Succesfully!'
          redirect_to food_path
        else
          render :new, alert: 'Error occured!'
        end
      end
    end
  end

  def destroy
    food = Food.find(params[:id])
    food.destroy
    redirect_to food_path
  end
end
