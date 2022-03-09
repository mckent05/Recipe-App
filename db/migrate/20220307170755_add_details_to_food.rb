class AddDetailsToFood < ActiveRecord::Migration[7.0]
  def change
    add_column :foods, :name, :string
    add_column :foods, :measurement_unit, :string
    add_column :foods, :price, :string
    add_reference :foods, :user, null: false, foreign_key: true
  end
end
