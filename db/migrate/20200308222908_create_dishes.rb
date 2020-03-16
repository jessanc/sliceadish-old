class CreateDishes < ActiveRecord::Migration[5.1]
  def change
    create_table :dishes do |t|
      t.string :title
      t.string :slug
      t.text :description
      t.text :image_data
      t.string :cuisine

      t.timestamps
    end
  end
end
