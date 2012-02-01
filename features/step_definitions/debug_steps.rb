Given /^(?:I )?start the debugger$/ do
  debugger
  dummy_var = 42 # necessary because the debugger actually stops AFTER the debugger line--which exits the method
end

Given /^(?:I )?dump the page source$/ do
  puts '-' * 80
  puts page.body
  puts '-' * 80
end

