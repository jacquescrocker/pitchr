class Lead
  include Pitchr::Document

  belongs_to :user

  field :name, :type => String
  field :referral_url, :type => String

  # TODO
  # track the pitch used

  # TODO
  # track the results

end