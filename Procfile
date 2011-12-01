# web: bundle exec thin start -p $PORT
web: bundle exec unicorn -p $PORT -c ./config/unicorn.rb

# scheduler: bundle exec rake resque:scheduler
# checkers: bundle exec rake QUEUE=checkers jobs:work
# notifiers: bundle exec rake QUEUE=notifiers,cleaners jobs:work