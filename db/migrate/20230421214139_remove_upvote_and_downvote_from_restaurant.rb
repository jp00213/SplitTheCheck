class RemoveUpvoteAndDownvoteFromRestaurant < ActiveRecord::Migration[6.1]
  def change
    remove_column :restaurants, :upvote, :integer
    remove_column :restaurants, :downvote, :integer
  end
end
