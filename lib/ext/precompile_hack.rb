# hack for heroku (precompile cant use mongo)
if ARGV.join(" ").include?("assets:precompile") || ENV["NOMONGO"].present?
  puts "No mongo connections allowed while precompiling... (NOMONGO=true)"
  ENV["NOMONGO"] = "true"
end

if ENV["NOMONGO"] == "true"
  # override Mongoid::Config
  module Mongoid
    module Config
      def load!(path)
        puts "Skipping Mongoid::Config.load! (NOMONGO=true)"
      end
    end
  end
end