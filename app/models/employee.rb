class Employee < ApplicationRecord
  has_secure_password
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
 
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: VALID_EMAIL_REGEX }, allow_blank: true
  validates :password, confirmation: true

  belongs_to :gender
  has_one :profile_image, dependent: :destroy
  accepts_nested_attributes_for :profile_image
end
