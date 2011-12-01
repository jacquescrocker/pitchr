module Templates
  class ReadyMadeController < ApplicationController
    layout "templates/ready_made"
    
    def login
      render :layout => false
    end
  end
end