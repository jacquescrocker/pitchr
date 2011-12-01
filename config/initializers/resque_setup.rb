require "resque_scheduler"
require 'resque/failure/multiple'
require 'resque/failure/airbrake'
require 'resque/failure/redis'

uri = URI.parse(Settings.redis_url)
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

Resque.schedule = YAML.load_file(File.join(File.dirname(__FILE__), '../scheduler.yml'))

Resque::Failure::Multiple.classes = [Resque::Failure::Redis, Resque::Failure::Airbrake]
Resque::Failure.backend = Resque::Failure::Multiple
