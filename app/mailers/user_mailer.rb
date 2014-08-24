class UserMailer < ActionMailer::Base

  default :from => "cbriguetvd@gmail.com"
 
  def password_reset(user)
    @user = user
    mail(:to => "#{user.name} <#{user.email}>", :subject => "Password Reset")
  end
 
  def registration_confirmation(user)
    @user = user
    filepng = "#{Rails.root}/app/assets/images/rails.png"
    if File.file?(filepng)
      attachments[filepng] = File.read(filepng)
    end  
    mail(:to => "#{user.name} <#{user.email}>", :subject => "Registered")
  end
  
  def micropost_mail(user, micropost)
    @user = user
    @micropost = micropost
    mail( :from => "#{user.name} <#{user.email}>", :to => "cbriguetvd@gmail.com", :cc => "#{user.name} <#{user.email}>", :subject => "New Micropost from #{user.name}")
  end
  
end
