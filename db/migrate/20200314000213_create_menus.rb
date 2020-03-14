class CreateMenus < ActiveRecord::Migration[5.1]
  def change
    create_table :menus do |t|
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
