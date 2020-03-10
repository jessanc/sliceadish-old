class UsersController < ApplicationController
 before_action :authenticate_user!
 before_action :set_user, only: [:update, :subscription]
 def subscription
 end
 def update
   if @user.update(user_params)
     flash[:notice] = 'Your changes have been saved.'
     redirect_back(fallback_location: root_path)
   else
     flash[:notice] = 'Could not update, Please try again'
   end
 end
private
  def set_user
    @user = current_user
  end
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :avatar, :remove_avatar, :stripe_user_id, :stripe_subscription_id, :plan)
  end
end
