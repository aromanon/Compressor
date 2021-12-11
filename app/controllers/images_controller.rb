class ImagesController < ApplicationController
  def index; end

  def compress
    compressor = Image::Compressor.call(params[:image], params[:email])
    compressor.on_success do
      redirect_to root_path, flash: { success: 'Image has been uploaded' }
    end

    compressor.on_failure do
      redirect_to root_path, flash: { danger: compressor.errors }
    end
  end

  def download
    send_file("#{Rails.root}/#{Dir["uploads/#{params[:uuid]}*"].first}")
  end
end
