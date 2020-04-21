class User < ApplicationRecord
  validates :name, presence: true, uniqueness:true
  has_secure_password
  after_destroy :enusre_an_admin_remains
  validates :email, uniqueness: {case_sensitive: false}, format: {with: /.+@.+\..+/}
  has_many :orders, dependent: :restrict_with_error
  has_one :address
  accepts_nested_attributes_for :address, reject_if: :all_blank, update_only: true, allow_destroy: true

  def address
    super || build_address
  end

  class Error < StandardError
  end

  private
    def enusre_an_admin_remains
      if User.count.zero?
        raise Error.new "Cannot Delete last user"
      end
    end
end
