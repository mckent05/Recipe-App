class Recipe < ApplicationRecord
  has_many :recipe_foods, class_name: 'RecipeFood', foreign_key: 'recipe_id', dependent: :destroy
  has_many :foods, through: :join_association, source: :join_association_table_foreign_key_to_foods_table
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
end
