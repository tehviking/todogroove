Feature: Manage tasks
  In order to get stuff done
  As a task doer
  I want to manage my tasks

  Background:
    Given I am logged in
  
  Scenario: Create task
    When I create a task
    Then I should be on the tasks page
    And I should see the task

  Scenario: Delete task
    Given some tasks are set up
    When I delete a task
    Then I should be on the tasks page
    And I should not see the task

  Scenario: Archive task
    Given some tasks are set up
    When I archive a task
    Then the task should be archived
    
  Scenario: Unarchive task
    Given some tasks are set up
    And some tasks are archived
    When I unarchive a task
    Then the task should not be archived
    
  Scenario: Complete a task
    Given some tasks are set up
    When I complete a task
    Then I should be on the tasks page
    And I should see the task in the finished section

  Scenario: Uncomplete a task
    Given some tasks are set up
    And a task is completed
    When I uncomplete a task
    Then I should be on the tasks page
    And I should see the task in the unfinished section

  Scenario: Tag a task
    When I create a task and tag it with "Home, Computer"
    Then I should be on the tasks page
    And I should see the task
    When I go to the "Computer" tasks page
    Then I should see the task
    When I go to the "Pants" tasks page
    Then I should not see the task

  Scenario: Pomodoros
    When I create a task with 3 estimated pomodoros and 1 completed pomodoro
    Then I should be on the tasks page
    And I should see the task with 1/3 pomodoros completed

#   Scenario: Pomodoros Reestimated
#     When I create a task with 3 estimated pomodoros and 5 completed pomodoros
#     Then I should be on the tasks page
#     And I should see the task with 3/3 pomodoros completed and 2 underestimated pomodoros
