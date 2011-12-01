class SettingsController < ApplicationController
  layout "application"
  before_filter :login_required

  def index

  end

  def update
    # TODO: update user settings
  end
end