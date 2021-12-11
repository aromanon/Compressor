module Image
  class Compressor < BaseService
    attr_reader :image, :email, :errors

    def initialize(image, email)
      @image = image
      @email = email
    end

    def call
      begin
        uploader = ImageUploader.new
        uploader.store!(image)

        ::CompressWorker.perform_async(uploader.filename, email)
      rescue => e
        @errors = e.message
      end

      self
    end
  end
end
