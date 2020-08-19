# CarrierWave.configure do |config|
#   config.fog_credentials = {
#     provider: 'AWS',
#     aws_access_key_id: ENV['S3_ACCESS_KEY'],
#     aws_secret_access_key: ENV['S3_SECRET_KEY'],
#     region: ENV['S3_REGION']
#   }

#   config.fog_directory  = 'rails-image-0327'
#   config.cache_storage = :fog

if Rails.env.development?                                                                                                                   
  CarrierWave.configure do |config|
    config.storage = :file
  end 
elsif Rails.env.test?
  CarrierWave.configure do |config|
   config.storage = :file
  end 
else
  CarrierWave.configure do |config|
    config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['S3_ACCESS_KEY'],
    aws_secret_access_key: ENV['S3_SECRET_KEY'],
    region: ENV['S3_REGION']
  	}
    config.cache_storage = :fog # fogを使う環境だけに適用
  end 
end
# end