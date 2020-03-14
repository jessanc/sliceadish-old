ActiveAdmin.register Menu do
    permit_params :start_date, :end_date, dish_ids: []

    index do
    selectable_column
    id_column
    column :start_date
    column :end_date
    column :dishes do |menu|
        table_for menu.dishes.order('title ASC') do
        column do |dish|
            dish.title
        end
        end
    end
    actions
    end

    show do
    attributes_table do
        row :start_date
        row :end_date
        row:dishes do |menu|
        table_for menu.dishes.order('title ASC') do |dish|
        column do |dish|
            link_to dish.title, [ :admin, dish ]
        end
        end
        end
    end
    end

    form do |f|
    f.inputs "Add/Edit Article" do
        f.input :start_date
        f.input :end_date
        f.input :dishes, :as => :check_boxes
    end
    actions
    end

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

end
