CarrierWave.configure do |config|
  if Rails.env.production?
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV[S3_RAILS_PROFILE_PHOTO_ACCESS_KEY],
      aws_secret_access_key: ENV[S3_RAILS_PROFILE_PHOTO_SECRET_ACCESS_KEY],
      region: 'ap-northeast-1'
    }
  
    config.fog_directory = "rails-profile-photo"
    config.cache_storage = :fog
  end
end
