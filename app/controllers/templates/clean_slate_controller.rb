module Templates
  class CleanSlateController < ApplicationController
    layout "templates/clean_slate"
    
    def login
      render :layout => false
    end
  end
end