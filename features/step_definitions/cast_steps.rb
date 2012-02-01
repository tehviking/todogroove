Given /^user "(.+?)" from the Cast of Characters is set up$/ do |user|
  case user
    when /Paul/
    User.create(:name => 'Paul Pomodoro', :email => 'paul@test.todogroove.com', :password => 'password', :password_confirmation= => 'password')
    else
    raise "Cast of Characters: Unrecognized user"
  end

end


