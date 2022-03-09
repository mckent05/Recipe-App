class ChangeQuantityToBeStringInRecipeFoodsTable < ActiveRecord::Migration[7.0]
  def change
    change_column :recipe_foods, :quantity, :string
  end
end
