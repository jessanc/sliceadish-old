class CreateReviews < ActiveRecord::Migration[5.1]
  def change
   create_table :reviews do |t|
     t.text :body
     t.integer :rating
     t.references :dish, index: true
     t.references :user, index: true
     t.datetime :created_at
     t.timestamps null: false
   end
   add_foreign_key :reviews, :dishes
   add_foreign_key :reviews, :users
 end
end
