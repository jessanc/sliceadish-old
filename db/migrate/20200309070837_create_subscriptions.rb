class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.references :user, index: true
      t.timestamps null: false
    end
    add_foreign_key :subscriptions, :users
  end
end
