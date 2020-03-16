class AddSettingsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :stripe_user_id, :string
    add_column :users, :stripe_subscription_id, :string
    add_column :users, :plan, :string, :default => 'free'
    add_column :users, :slug, :string
    add_column :users, :address1, :string
    add_column :users, :address2, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :zip, :string
    add_column :users, :phone_number, :string
    add_column :users, :special_instructions, :string
    add_column :users, :dietary_preferences, :string
    add_column :users, :delivery_day, :string
    add_column :users, :country, :string
  end
end
