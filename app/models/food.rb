class Food < ApplicationRecord
  has_many :recipe_foods, class_name: 'RecipeFood', foreign_key: 'food_id', dependent: :destroy
  has_many :recipes, through: :recipe_foods
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'

  validates :name, presence: true
  validates :measurement_unit, presence: true
end
