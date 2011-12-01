class ApplicationController < ActionController::Base
  # protect_from_forgery

  protected

  helper_method :logged_in?
  def logged_in?
    current_user.present?
  end

  def login_required
    if current_user.present?
      return true
    else
      redirect_to "/login"
      return false
    end
  end

  def billing_required
    # don't do anything if not logged in
    return true if current_user.blank?

    if current_user.subscription.present?
      return true
    else
      redirect_to "/billing"
      return false
    end
  end

  def current_user
    @current_user ||= begin
      User.by_id(session[:user_id])
    end
  end

  def current_user=(user)
    if user.present?
      session[:user_id] = user.id.to_s
    else
      session[:user_id] = nil
    end
  end

  before_filter :force_domain
  def force_domain
    return true unless Settings.force_domain
    return true if request.xhr?
    return true if Rails.env.test?

    # check if we're on the right domain, if not redirect
    redirect_url = Pitchr::Routing::ForceDomain.new(Settings.force_domain).redirect?(request)

    if redirect_url.blank?
      return true
    else
      redirect_to(redirect_url)
      return false
    end
  end

  before_filter :set_user_time_zone
  def set_user_time_zone
    # if user_signed_in?
    #   Time.zone = current_user.time_zone if current_user.time_zone.present?
    # end
    return true
  end

end
