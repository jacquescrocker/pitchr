require 'resque/tasks'
require 'resque_scheduler/tasks'

task "resque:setup" => :environment do
  ENV["VVERBOSE"] = "1" if Rails.env.development?
end
task "resque:scheduler_setup" => :environment

# for all the web background jobs (run via heroku workers)
desc "Starts the heroku worker"
task "jobs:work" => :environment do
  ENV["QUEUE"] ||= Settings.workers.heroku.to_s
  ENV["INTERVAL"] ||= Settings.workers.update_interval.to_s

  puts "PROCESSING QUEUE: #{ENV['QUEUE']}"
  Rake::Task["resque:setup"].invoke
  Rake::Task["resque:work"].invoke
end