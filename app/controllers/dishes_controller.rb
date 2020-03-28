class DishesController < ApplicationController
  before_action :set_dish, only: [:show]

  def index
    @dishes = Dish.all
  end

  def show
    @review = Review.new
    @reviews = @dish.reviews
  end

  private
    def set_dish
     @dish = Dish.find(params[:id])
   end

end
