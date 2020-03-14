class AddMenuIdToDishes < ActiveRecord::Migration[5.1]
  def change
    add_reference :dishes, :menu, foreign_key: true
  end
end
