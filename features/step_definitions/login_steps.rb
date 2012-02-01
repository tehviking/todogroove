Given /^I log in as "([^"]+)" with password "([^"]+)"$/ do |user, password|
  Given "user \"#{user}\" from the Cast of Characters is set up"
  Given 'I go to the login page'
  Given 'I fill in "email" with "paul@test.todogroove.com"'
  Given 'I fill in "password" with "' + password + '"'
  Given 'I press "Log in"'
end

Given /^I (?:log|am logged) in as "([^"]+)"$/ do |user|
  Given "I log in as \"#{user}\" with password \"password\""
end


Given /^I (?:log|am logged) in$/ do
  Given 'I am logged in as "Paul"'
end

Given /^I (?:log|am logged) out$/ do
  Given 'I go to the home page'
  And 'I follow "Log Out"'
end
