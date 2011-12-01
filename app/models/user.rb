class User
  include Pitchr::Document
  include Pitchr::PasswordAuth

  field :email, :type => String
  validates_presence_of :email, :message => "can't be blank"
  validates_uniqueness_of :email, :on => :create, :message => "must be unique"
  validates :email, :email => {}, :allow_blank => true

  references_one :subscription
  references_many :leads
  references_many :pitches

end