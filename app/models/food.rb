class Food < ApplicationRecord
    has_many :recipe_foods, class_name: "RecipeFood", foreign_key: "food_id", dependent: :destroy
    has_many :recipes, through: :join_association, source: :join_association_table_foreign_key_to_recipes_table
    belongs_to :user, class_name: "User", foreign_key: "user_id"
end
