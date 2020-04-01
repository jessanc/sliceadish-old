require 'date'

class SubscriptionsController < ApplicationController
#as usual we want to have only authenticated users access our subscription actions
  before_action :authenticate_user!
  @@cart = Hash.new(0)
  @@plan
  @@plan_details
  def plans
    render layout: "plans"
  end
  def new
    puts "in new"
    puts params
    @amount = @@plan_details[0]
    @plan_name = @@plan_details[1]
    @user = User.new
    @taxrate = 0.065
    render layout: "checkout"
  end
  def create
    customer =  if current_user.subscription.stripe_user_id?
                  Stripe::Customer.retrieve(current_user.subscription.stripe_user_id)
                else
                  Stripe::Customer.create(
                    :email => current_user.email,
                    :source => params[:stripeToken]
                  )
                end
    if current_user.subscription.active
      flash[:error] = 'Already a subscriber!'
      redirect_to root_path and return
    end
    wa_taxrate= Stripe::TaxRate.retrieve(
                'txr_1GKiGHGNXNhAWgyjqzbjYHDw',
                )
    current_subscriptions = customer.subscriptions
    puts current_subscriptions
    subscription = customer.subscriptions.create(
      plan: @@plan,
      billing_cycle_anchor: get_subscription_starttime(),
      prorate: 'false',
      tax_percent: wa_taxrate.percentage
    )
    mealCount = @@plan_details[2]
    current_user.subscription.stripe_user_id = customer.id
    current_user.subscription.active = true
    current_user.subscription.meal_count = mealCount
    current_user.subscription.save
    options = {
      stripe_user_id: customer.id,
      stripe_subscription_id: subscription.id,
      plan: @@plan
    }
    flash[:notice] = 'Successfully Subcribed!'
    redirect_to root_path
  end
  def choose_meals
    @@plan = params[:plan]
    @@cart ||= Hash.new(0)
    @cart = @@cart
    # @amount = params[:amount]
    begin
      @@plan_details = get_plan_details(params[:plan])
    rescue
      flash[:notice] = 'Not a valid plan.'
      redirect_to(:plans) and return
    end
    total = @@cart.inject(0) { |sum, tuple| sum += tuple[1] } 
    if total > @@plan_details[2]
      @@cart.clear()
    end
    # menu to display
    @menu = Menu.where(end_date: Date.today..1.week.from_now)
    #@@cart.clear
    puts "Current cart #{@@cart}"
    render layout: "choose_meals"
  end
  def add_to_cart
    puts params[:dish_id]
    total = @@cart.inject(0) { |sum, tuple| sum += tuple[1] } 
    if total >= @@plan_details[2]
      flash[:notice] = 'Only ' + @@plan_details[2].to_s + ' meals allowed in cart.'
      redirect_back fallback_location: root_path
      return
    end
    dish_id = params[:dish_id]
    @@cart[Dish.find(dish_id)] += 1
    #@@cart.push(Dish.find(dish_id), 1)
    puts @@cart
    puts "total #{total + 1}"
    redirect_back fallback_location: root_path
  end
  def clear_cart
    @@cart.clear
    redirect_back fallback_location: root_path
  end
  def remove_from_cart
     puts "Current cart #{@@cart}"
     dish = Dish.find(params[:dish_id])
     if !@@cart.key?(dish)
      flash[:error] = 'Dish not in cart'
      redirect_back fallback_location: root_path and return
     end
     @@cart[dish] -=1
     if @@cart[dish] == 0
      @@cart.delete(dish)
     end
     puts "Current cart #{@@cart}"
    redirect_back fallback_location: root_path
  end
  def update
    @plan = params[:plan]
  end
  def destroy
    customer = Stripe::Customer.retrieve(current_user.subscription.stripe_user_id)
    subscriptions = customer.subscriptions
    subscriptions.each do |sub|
      sub.delete
    end
    # subscription = Stripe::Subscription.retrieve(current_user.stripe_subscription_id)
    # subscription.delete(:at_period_end => true)
    #subscription.delete
    # current_user.update(stripe_subscription_id: nil, cc_last4: nil, cc_exp_month: nil, cc_exp_year: nil, cc_type: nil)
    @plan = params[:plan]
    current_user.subscription.meal_count = nil
    current_user.subscription.active = false
    current_user.subscription.save
    user = current_user
    redirect_to root_path, notice: "Your subscription has been canceled."
  end
  private
    def get_subscription_starttime
      date  = Date.parse("Thursday")
      delta = date > Date.today ? 0 : 7
      newdate = date + delta
      return newdate.to_time.to_i
    end
    def get_plan_details(pln)
      case pln
        when nil  # current_user != nil, skip condition
          raise "This is an exception"
        when "four"  # current_user != current_user.is_admin?, skip condition
          return 59.99, "Four meals", 4 #amount, plan details, count
        when "nine"  # and so on
          return 69.99, "Nine meals", 9
        else
          raise "This is an exception"
        end
    end

end