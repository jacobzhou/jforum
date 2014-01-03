# encoding: utf-8
ActionMailer::Base.smtp_settings = {
  :address              => "smtpcloud.sohu.com",
  :port                 => 25,
  :domain               => "",
  :user_name            => "postmaster@jacob.sendcloud.org",
 	:password             => "LufMi0qV",
  :authentication       => "login",
  :enable_starttls_auto => true
}

