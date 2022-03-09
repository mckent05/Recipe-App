class Recipe < ApplicationRecord
  has_many :recipe_foods, class_name: 'RecipeFood', foreign_key: 'recipe_id', dependent: :destroy
  has_many :foods, through: :recipe_foods
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'

  validates :name, presence: true
end
