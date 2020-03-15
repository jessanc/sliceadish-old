class Removeshitfromuser < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :stripe_user_id, :string
    remove_column :users, :stripe_subscription_id, :string
    remove_column :users, :plan, :string, :default => 'free'
    remove_column :users, :slug, :string
    remove_column :users, :address1, :string
    remove_column :users, :address2, :string
    remove_column :users, :city, :string
    remove_column :users, :state, :string
    remove_column :users, :zip, :string
    remove_column :users, :phone_number, :string
    remove_column :users, :special_instructions, :string
    remove_column :users, :dietary_preferences, :string
    remove_column :users, :delivery_day, :string
    remove_column :users, :country, :string
  end
end
