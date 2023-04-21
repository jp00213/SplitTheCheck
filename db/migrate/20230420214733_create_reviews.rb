class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.references :restaurant, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :upvote, default: 0
      t.integer :downvote, default: 0
      
      t.timestamps
    end
  end
end
