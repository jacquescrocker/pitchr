class ApplicationController < ActionController::Base
  # protect_from_forgery

  protected

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
