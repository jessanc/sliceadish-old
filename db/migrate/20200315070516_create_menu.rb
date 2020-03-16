class CreateMenu < ActiveRecord::Migration[5.1]
  def change
    create_table :menus do |t|
      t.date :start_date
      t.date :end_date, :unique => true    
    end
  end
end
