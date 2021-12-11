require 'carrierwave'

class ImageUploader < CarrierWave::Uploader::Base
  storage :file

  def extension_white_list
    %w[jpg jpeg gif png]
  end

  def store_dir
    'uploads'
  end
end
