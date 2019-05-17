class ProfileImage < ApplicationRecord
  belongs_to :employee
  mount_uploader :image, ProfileImageUploader
end
