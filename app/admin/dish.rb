ActiveAdmin.register Dish do
  permit_params :title, :description, :slug, :image, :remove_image, :cuisine, :created_at, :updated_at
  index do
    id_column
    column :title
    column :cuisine
    actions
  end
  form do |f|
    f.semantic_errors
    f.inputs 'Dish' do
        f.input :title
        f.input :description
        f.input :slug
        f.input :cuisine
        f.inputs "Attachment", :multipart => true do
        f.input :image, :as => :file, :hint => f.object.image.present? \
            ? image_tag(f.object.image_url(:thumb))
            : content_tag(:span, "no image yet")
        f.input :image_attacher, :as => :hidden
        end
    end
    f.actions
  end
  # sidebar "Add", only: [:show, :edit] do
  #   ul do
  #     li link_to "Restaurant",    admin_dish_restaurant_path(resource)
  #   end
  # end
end
