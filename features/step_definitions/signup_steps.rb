Given /^the following signups:$/ do |signups|
  Signup.create!(signups.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) signup$/ do |pos|
  visit signups_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following signups:$/ do |expected_signups_table|
  expected_signups_table.diff!(tableish('table tr', 'td,th'))
end

When /^I sign up as "(.+?)" with email "(.+?)"$/ do |name, email|
  Given 'I am on the signup page'
  Given 'I fill in "Name" with "' + name + '"'
  Given 'I fill in "Email" with "' + email + '"'
  Given 'I fill in "Password" with "password"'
  Given 'I fill in "Password confirmation" with "password"'
  Given 'I press "Create User"'
end

When /^I sign up$/ do
  Given 'I sign up as "Bob" with email "bob@test.todogroove.com"'
end

