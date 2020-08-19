class ImageUploader < CarrierWave::Uploader::Base
 include CarrierWave::MiniMagick
 process resize_to_limit: [200, 200]
  
  if Rails.env.development?
    storage :file
  elsif Rails.env.test?
    storage :file
  else
    storage :fog
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  
  
  #画像の拡張子が指定されていないとエラーが出る
  def extension_whitelist
    %w(jpeg git png jpg)
  end

  def filename
    original_filename if original_filename
  end
end
