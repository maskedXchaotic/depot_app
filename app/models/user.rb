class User < ApplicationRecord
  validates :name, presence: true, uniqueness:true
  has_secure_password
  after_destroy :enusre_an_admin_remains
  validates :email, uniqueness: {case_sensitive: false}, format: {with: /.+@.+\..+/}

  after_create :send_welcome_mail
  before_destroy :ensure_is_not_admin
  before_update :ensure_is_not_admin
  
  class Error < StandardError
  end

  private
    def enusre_an_admin_remains
      if User.count.zero?
        raise Error.new "Cannot Delete last user"
      end
    end

    def send_welcome_mail
      OrderMailer.welcome(self).deliver_later
    end

    def ensure_is_not_admin
      throw :abort if self.email == 'admin@depot.com'
    end
end
