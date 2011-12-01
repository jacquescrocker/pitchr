class Pitch
  include Pitchr::Document
  
  belongs_to :user
  
  field :title, :type => String
  field :body, :type => String
  
end