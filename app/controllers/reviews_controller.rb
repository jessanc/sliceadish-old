class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reviews = @dish.reviews
    @review = Review.find(params[:id])
  end

  def create
    @review = current_user.reviews.create(body: params[:review][:body], rating: params[:review][:rating], dish_id: params[:review][:dish_id])
    redirect_back(fallback_location: @dish)
    flash[:notice] = 'Your review was added successfully!'
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_back(fallback_location: @dish)
    flash[:notice] = 'Your review was successfully deleted!'
  end

  private

  def review_params
    params.require(:review).permit(:rating, :body, :dish_id, :user_id)
  end

end
