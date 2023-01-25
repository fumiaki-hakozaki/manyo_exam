class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: {maximum: 255 }
  validates :email,format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, length: { minimum: 6 }, on: :new
  has_many :tasks, dependent: :destroy

  before_destroy :admin_user_cannot_destroy
  before_update :admin_user_cannot_update

  private
  def admin_user_cannot_update
    throw :abort if self.admin == false && User.where(admin:true).count == 1
  end

  def admin_user_cannot_destroy
    throw :abort if self.admin == true && User.where(admin:true).count == 1
  end
end
