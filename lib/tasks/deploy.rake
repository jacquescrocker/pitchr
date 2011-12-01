# Deploy Tasks
task :deploy =>  ["heroku:deploy"]
task :console => ["heroku:console"]
task :setup =>   ["heroku:setup"]

# Heroku Deploy Callbacks
namespace :heroku do

  # runs before each push to a particular heroku deploy environment
  task :before_each_deploy do
    $DEPLOYING = true

    # grab the environment settings of the deploy environment (for s3 stuff)
    Settings.add_source!("#{Rails.root}/config/settings/#{@heroku_app[:env]}.yml")
    Settings.reload!
  end

  task :after_each_deploy do
    ENV["TO"] = @heroku_app[:env]
    ENV["REVISION"] = `git log -1 --pretty=format:%H`

    if Settings.airbrake.present? and Settings.airbrake.repo.present?
      ENV["REPO"] = Settings.airbrake.repo
      # enable once our airbrake repo supports it
      # Rake::Task["airbrake:deploy"].invoke
    end
  end

  task :after_deploy do
    # send HTTP request to server
    `curl #{Settings.site_url}/`
  end
end

