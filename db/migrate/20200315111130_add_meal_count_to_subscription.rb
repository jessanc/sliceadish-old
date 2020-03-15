class AddMealCountToSubscription < ActiveRecord::Migration[5.1]
  def change
    add_column :subscriptions, :meal_count, :integer
  end
end
