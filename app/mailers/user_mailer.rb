class UserMailer < ApplicationMailer
  def success_compress
    @uuid = params[:uuid]
    email = params[:email]
    mail(to: email, subject: 'File has been compressed')
  end

  def error_compress
    email = params[:email]
    mail(to: email, subject: "File hasn't been compressed")
  end
end
