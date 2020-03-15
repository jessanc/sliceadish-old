ActiveAdmin.register User do
  permit_params :first_name, :last_name, :password, :password_confirmation, :confirmed_at, :email, :stripe_user_id, :stripe_subscription_id, :plan, :address1, :address2, :city, :state, :special_instructions, :dietary_preferences, :phone_number, :delivery_day

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    column :selections do |selections|
        table_for selections do |dish|
           column dish.title
        end
    end
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :confirmed_at
      f.input :first_name
      f.input :last_name
      f.input :stripe_user_id
      f.input :stripe_subscription_id
      f.input :plan
      f.input :address1
      f.input :address2
      f.input :city
      f.input :state
      f.input :zip
      f.input :phone_number
      f.input :special_instructions
      f.input :dietary_preferences
      f.input :delivery_day
    end
    f.actions
  end

end
