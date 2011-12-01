Pitchr::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true

  # nice to have the logger just print to STDOUT
  config.logger = Logger.new(STDOUT)

  # require fabricators
  Dir["#{Rails.root}/db/fabricators/**.rb"].each {|f| require f}

  # this makes things really slow, but allows each asset file to be included manually
  # config.assets.debug = true

  ## not sure about this...
  # config.to_prepare do
  #   Dir["#{Rails.root}/app/models/*.rb"].each {|file| require file }
  # end

  # save all incoming and outgoing requests
  unless $DEPLOYING
    require "vcr"
    require "webmock"

    # use vcr middleware
    config.middleware.use "VCR::Middleware::Rack", do |cassette|
      cassette.name "web"
      cassette.options :record => :all
    end

    VCR.config do |c|
      c.cassette_library_dir = 'tmp/vcr_cassettes'
      c.allow_http_connections_when_no_cassette = true
      c.stub_with :webmock # or :fakeweb
    end
  end

  config.after_initialize do
    # load fabricators
    Mongoid.database.profiling_level = :slow_only
  end

end
