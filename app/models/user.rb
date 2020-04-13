class User < ApplicationRecord
  validates :name, presence: true, uniqueness:true
  has_secure_password
  after_destroy :enusre_an_admin_remains
  validates :email, uniqueness: {case_sensitive: false},g format: {with: /.+@.+\..+/}
  has_many :orders, dependent: :restrict_with_error

  class Error < StandardError
  end

  private
    def enusre_an_admin_remains
      if User.count.zero?
        raise Error.new "Cannot Delete last user"
      end
    end
end
