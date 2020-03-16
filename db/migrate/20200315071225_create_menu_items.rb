class CreateMenuItems < ActiveRecord::Migration[5.1]
  def change
    create_table :menu_items do |t|
      t.belongs_to :menu, :null => false, :index => true
      t.belongs_to :dish, :null => false, :index => true
    end
  end
end
