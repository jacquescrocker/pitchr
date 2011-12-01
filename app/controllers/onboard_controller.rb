class OnboardController < ApplicationController
  layout "onboard"
  before_filter :login_required, :only => [:billing]

  def landing
    render :layout => nil
  end

  def login
    if request.get?
      render :login
    else
      # perform login
      user = User.where(:email => params[:email]).first
      if user && user.password_matches?(params[:password])
        self.current_user = user
        redirect_to "/pitches"
      else
        @login_error = true
        render :login
      end
    end
  end

  def logout
    self.current_user = nil
    redirect_to "/"
  end

  def register
    @user = User.new(user_attributes)
    if request.get?
      render :register
    else
      if @user.save
        self.current_user = @user
        redirect_to "/billing"
      else
        # perform register
        render :register
      end
    end
  end

  def billing
    @subscription = current_user.build_subscription
    if request.get?
      render :billing
    else
      @subscription.stripe_card_token = params[:stripe_card_token]
      if @subscription.save_with_payment
        redirect_to "/dashboard"
      else
        @subscription_errror = true
        # perform register
        render :billing
      end
    end
  end

  def terms

  end

  protected
  def user_attributes
    # choose only the attributes that are allowed to be editable
    (params[:user] || {}).slice(*[
      :email,
      :password,
      :password_confirmation,
    ])

  end

end
