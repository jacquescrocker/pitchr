require 'resque/server'

module Pitchr
  class ResqueServer < Resque::Server

    if Settings.backend.password.present?
      # protect using basic auth
      use Rack::Auth::Basic do |email, password|
        email == Settings.backend.password || password == Settings.backend.password
      end
    end

  end
end