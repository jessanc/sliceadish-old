class AddDishesToMenu < ActiveRecord::Migration[5.1]
  def change
    add_reference :menus, :dishes, foreign_key: true
  end
end
