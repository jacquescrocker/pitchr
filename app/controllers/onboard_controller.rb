class OnboardController < ApplicationController
  layout "onboard"
  before_filter :login_required, :only => [:billing]

  def login
    if request.get?
      render :login
    else
      # perform login
      render :login
    end
  end

  def register
    if request.get?
      render :register
    else
      # perform register
      render :register
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
end
