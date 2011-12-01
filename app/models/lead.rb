class Lead
  include Pitchr::Document

  belongs_to :user

  field :name, :type => String
  field :referenced_from, :type => String

  validates_presence_of :name, :on => :create, :message => "can't be blank"

  # TODO
  # track the pitch used

  # TODO
  # track the results

end