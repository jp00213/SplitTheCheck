class AddIndexToFavorites < ActiveRecord::Migration[6.1]
  def change
    add_index(:favorites, [:restaurant_id, :user_id], unique: true)
  end
end
