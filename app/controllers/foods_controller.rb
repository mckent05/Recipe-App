class FoodsController < ApplicationController
  def index
    @food = current_user.foods.all
  end

  def new
    @food = Food.new
  end

  def create
    food = current_user.foods.new(post_params)
    respond_to do |format|
      format.html do
        if food.save
          flash[:success] = 'Created New Food Succesfully!'
          redirect_to foods_path
        else
          render :new, alert: 'Error occured!'
        end
      end
    end
  end

  def destroy
    food = Food.find(params[:id])
    food.destroy
    redirect_to foods_path
    flash[:success] = 'Food Deleted!'
  end

  private

  def post_params
    params.require(:data).permit(:name, :measurement_unit, :price)
  end
end
