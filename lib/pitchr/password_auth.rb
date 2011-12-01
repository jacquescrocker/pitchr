require 'bcrypt'

module Pitchr
  module PasswordAuth
    extend ActiveSupport::Concern

    included do
      field :encrypted_password, :type => String

      attr_reader :password, :current_password
      attr_accessor :password_confirmation

      with_options :if => :password_required? do |v|
        v.validates_presence_of     :password
        v.validates_confirmation_of :password
        v.validates_presence_of     :password_confirmation
        v.validates_length_of       :password, :within => password_length, :allow_blank => true
      end

    end

    # checks to see if a password matches
    def password_matches?(password)
      return false if encrypted_password.blank?
      bcrypt   = ::BCrypt::Password.new(self.encrypted_password)
      password = ::BCrypt::Engine.hash_secret("#{password}#{self.class.pepper}", bcrypt.salt)
      secure_compare(password, self.encrypted_password)
    end

    # Generates password encryption based on the given value.
    def password=(new_password)
      @password = new_password
      self.encrypted_password = password_digest(@password) if @password.present?
    end

    def password_required?
      !persisted? || !password.nil? || !password_confirmation.nil?
    end

    def secure_compare(a, b)
      return false if a.blank? || b.blank? || a.bytesize != b.bytesize
      l = a.unpack "C#{a.bytesize}"

      res = 0
      b.each_byte { |byte| res |= byte ^ l.shift }
      res == 0
    end

    module ClassMethods
      def pepper
        "4c271fb4191a78fb41184b6230adf18551d6eb509669a199f6bd9955ec0bfba09b7da3b3e1bd09f59e226dc95e024601830a1b166a62f84df9a1cb79aef07e5b"
      end

      def stretches
        10
      end

      def password_length
        4..100
      end
    end

    protected

      # Digests the password using bcrypt.
      def password_digest(password)
        ::BCrypt::Password.create("#{password}#{self.class.pepper}", :cost => self.class.stretches).to_s
      end

  end
end