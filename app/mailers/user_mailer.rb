class UserMailer < ActionMailer::Base

  def reset_password_email(user)
    setup_email(user)
    @subject += "Your ToDoGroove password reset instructions"
    @body[:url] = "http://#{SITE_NAME}/users/reset_password/#{user.reset_token}"
  end
  
  protected
  
  def setup_email(user)
    @recipients = "#{user.email}"
    @from = "ToDoGroove Admin"
    @subject = ""
    @sent_on = Time.now
    @body[:user] = user
  end  
end