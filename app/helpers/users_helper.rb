module UsersHelper
  def user_image(user)
    if user.image_data.nil?
      image_tag 'logo.png', width: 30, height: 30, class: 'user-image-rounded'
    else
      if user.image_data.starts_with?('{')
        image_tag user.image_url(:thumb), width: 30, height: 30, class: 'user-image-rounded'
      else
        image_tag user.image_data, width: 30, height: 30, class: 'user-image-rounded'
      end
    end
  end
end
