class CompressWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(filename, email)
    path = "uploads/#{filename}"
    webp_path = "uploads/#{jid}-#{filename}.webp"

    begin
      WebP.encode(path, webp_path, { quality: 80, method: 5 })
      UserMailer.with(uuid: jid, email: email).success_compress.deliver_later
    rescue
      UserMailer.with(email: email).error_compress.deliver_later
    end
  end
end
