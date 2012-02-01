# encoding: UTF-8

# Given /^the following tasks:$/ do |tasks|
#   Task.create!(tasks.hashes)
# end


Given /^the (\d+)(?:st|nd|rd|th) task is "(.+)"$/ do |pos, name|
  within("div#content div:nth-child(#{pos.to_i})") do
    Given "I should see \"#{name}\""
  end
end

When /^I delete the (\d+)(?:st|nd|rd|th) task$/ do |pos|
  within("div#content div:nth-child(#{pos.to_i})") do
    click_link "Delete"
  end
end

When /^I archive the (\d+)(?:st|nd|rd|th) task$/ do |pos|
  within("div#content div:nth-child(#{pos.to_i})") do
    click_link "Archive"
  end
end

When /^I unarchive the (\d+)(?:st|nd|rd|th) task$/ do |pos|
  within("div#content div:nth-child(#{pos.to_i})") do
    click_link "Unarchive"
  end
end

When /^I complete the (\d+)(?:st|nd|rd|th) task$/ do |pos|
  within("div#content div.task_container:nth-child(#{pos.to_i})") do
    click_link "Done"
  end
end

When /^I uncomplete the (\d+)(?:st|nd|rd|th) task$/ do |pos|
  within("div#content div.task_container:nth-child(#{pos.to_i})") do
    click_link "Undo"
  end
end

# Then /^I should see the following tasks:$/ do |expected_tasks_table|
#   expected_tasks_table.diff!(tableish('table tr', 'td,th'))
# end

When /^I create a task named "([^\"]*)" tagged with "([^\"]*)" with (\d+) estimated pomodoro(?:s)? and (\d+) completed pomodoro(?:s)?$/ do |task_name, tags, estimated_poms, completed_poms|
  Given 'I am on the new task page'
  Then 'I fill in "Name" with "' + task_name + '"'
  Then 'I fill in "Tags" with "' + tags + '"'
  Then 'I fill in "Estimated Pomodoros" with "' + estimated_poms + '"'
  Then 'I fill in "Completed Pomodoros" with "' + completed_poms + '"'
  Then 'I uncheck "Done"'
  Then 'I press "Create Task"'
  Then 'I should be on the tasks page'
end

When /^I create a task named "([^\"]*)" tagged with "([^\"]*)"$/ do |task_name, tags|
  Given "I create a task named \"#{task_name}\" tagged with \"#{tags}\" with 1 estimated pomodoros and 0 completed pomodoros"
end

Given /^I create a task named "([^\"]+)"$/ do |task_name|
  Given "I create a task named \"#{task_name}\" tagged with \"Home\""
end

When /^I create a task with (\d+) estimated pomodoro(?:s)? and (\d+) completed pomodoro(?:s)?$/ do |estimated_poms, completed_poms|
  Given "I create a task named \"Test 1 Task\" tagged with \"Home\" with #{estimated_poms} estimated pomodoros and #{completed_poms} completed pomodoros"
end

When /^I create a task$/ do
  Given 'I create a task named "Test 1 Task"'
end

When /^I create a task and tag it with "([^\"]*)"$/ do |tags|
  Given "I create a task named \"Test 1 Task\" tagged with \"#{tags}\""
end


Then /^I should see the task$/ do
  Given 'I should see "Test 1 Task"'
end

Given /^some tasks are set up$/ do
  Given 'I create a task named "Test 1 Task"'
  Given 'I create a task named "Test 2 Task"'
  Given 'I create a task named "Test 3 Task"'
end

When /^I delete a task$/ do
  Given 'I am on the tasks page'
  # have to delete by position, so here's a sanity check to make sure it's Test 1 Task
  Given 'the 1st task is "Test 1 Task"'
  Given 'I delete the 1st task'
end

When /^I archive a task$/ do
  Given 'I am on the tasks page'
  # have to delete by position, so here's a sanity check to make sure it's Test 1 Task
  Given 'the 1st task is "Test 1 Task"'
  Given 'I archive the 1st task'
end

When /^I unarchive a task$/ do
  Given 'I am on the archive page'
  # have to delete by position, so here's a sanity check to make sure it's Test 1 Task
  Given 'the 1st task is "Test 1 Task"'
  Given 'I unarchive the 1st task'
end

When /^I complete a task$/ do
  Given 'I am on the tasks page'
  Given 'the 1st task is "Test 1 Task"'
  Given 'I complete the 1st task'
end

Then /^I should not see the task$/ do
  Given 'I should not see "Test 1 Task"'
end

Then /^I should see the task in the finished section$/ do
  within("div#content div.done") do
    Then 'I should see "Test 1 Task"'
  end
end

Then /^I should see the task in the unfinished section$/ do
  within("div#content div.not_done") do
    Then 'I should see "Test 1 Task"'
  end
end

Given /^a task is completed$/ do
  Given 'I complete a task'
end

When /^I uncomplete a task$/ do
  # have to delete by position, this is pretty hinky maybe we should fix it.
  Given 'I uncomplete the 3rd task'
end

Then /^I should see the task with (\d+)\/(\d+) pomodoros completed$/ do |done, est|
  done = done.to_i
  est = est.to_i - done
  est = 0 if est < 0
#  Then 'I should see "Test 1 Task ' + (['(✓)'] * done * ' ') + ' ' + (['(_)'] * est * ' ') + '"'
#  within("div#content div:nth-child(#{pos.to_i})") do
  page.should have_css("div.pom_container a.completed_pom", :count => done) if done > 0
  page.should have_css("div.pom_container a.uncompleted_pom", :count => est) if est > 0
end

Then /^the task should be archived$/ do
  When "I am on the tasks page"
  Then "I should not see the task"
  When "I am on the archive page"
  Then "I should see the task"
end

Then /^the task should not be archived$/ do
  When "I am on the tasks page"
  Then "I should see the task"
  When "I am on the archive page"
  Then "I should not see the task"
end

Given /^some tasks are archived$/ do
  Task.update_all(:archived => true)
end
