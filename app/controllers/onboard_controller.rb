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
        @invalid_login = true
        render :login
      end
    end
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
    # todo: make sure they're logged in

    if request.get?
      render :billing
    else
      # perform register
      render :billing
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
