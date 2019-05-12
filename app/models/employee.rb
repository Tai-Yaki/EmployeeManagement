class Employee < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
 
  validates :name, presence: true
  validates :email, presence: true
  validates :email, format: { with: VALID_EMAIL_REGEX }, allow_blank: true

  belongs_to :gender
end
