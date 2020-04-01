require 'date'

class SubscriptionsController < ApplicationController
#as usual we want to have only authenticated users access our subscription actions
  before_action :authenticate_user!
  def pricing
    render layout: "pricing"
  end
  def new
    @plan = params[:plan]
    # @amount = params[:amount]
    begin
      plan_details = get_plan_details(params[:plan])
    rescue
      flash[:notice] = 'Not a valid plan.'
      redirect_to(:pricing) and return
    end
    @amount = plan_details[0]
    @plan_name = plan_details[1]
    @user = User.new
    @taxrate = 0.065
    render layout: "checkout"
  end
  def create
    customer = if current_user.stripe_user_id?
                 Stripe::Customer.retrieve(current_user.stripe_user_id)
               else
                 Stripe::Customer.create(
                   :email => current_user.email,
                   :source => params[:stripeToken]
                 )
               end
    wa_taxrate= Stripe::TaxRate.retrieve(
               'txr_1GKiGHGNXNhAWgyjqzbjYHDw',
             )
    subscription = customer.subscriptions.create(
      plan: params[:plan],
      billing_cycle_anchor: get_subscription_starttime(),
      prorate: 'false',
      tax_percent: wa_taxrate.percentage
    )
    options = {
      stripe_user_id: customer.id,
      stripe_subscription_id: subscription.id,
      plan: params[:plan],
    }
    current_user.update(options)
    subscription = Subscription.create user_id: current_user.id
    redirect_to complete_path
  end
  def complete
  end
  def update
    @plan = params[:plan]
  end
  def destroy
    customer = Stripe::Customer.retrieve(current_user.stripe_user_id)
    subscription = Stripe::Subscription.retrieve(current_user.stripe_subscription_id)
    subscription.delete(:at_period_end => true)
    current_user.update(stripe_subscription_id: nil, cc_last4: nil, cc_exp_month: nil, cc_exp_year: nil, cc_type: nil)
    @plan = params[:plan]
    current_user.update(plan: 'free')
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
          return 59.99, "Four meals" #amount, plan details
        when "nine"  # and so on
          return 69.99, "Nine meals"
        else
          raise "This is an exception"
        end
    end

end