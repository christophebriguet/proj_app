ActionMailer::Base.smtp_settings = {
  :address              => "smtp.hispeed.ch",
  :port                 => 25,
  :domain               => "hispeed.ch",
  :user_name            => ENV["MAIL_USERNAME"],
  :password             => ENV["MAIL_PASSWORD"],
  :authentication       => "plain",
  :enable_starttls_auto => true
}

#ActionMailer::Base.default_url_options[:host] = "localhost:3000"

#ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?
