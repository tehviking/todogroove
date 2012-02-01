Feature: Login
  In order to see my data
  As a user of the system
  I want to login
  
  Scenario: Login
    When I log in as "Paul"
    Then I should be on the tasks page
    And I should see "Welcome, Paul"

  Scenario: Logout
    Given I am logged in
    When I log out
    Then I should be on the home page
    And I should see "Logged out!"

  Scenario: Login attempt with bad password
    When I log in as "Paul" with password "arglebargle"
    Then I should be on the sessions page
    And I should see "Invalid email or password"

#   Scenario: Access tasks or tags when not logged in
#     Given I am logged out
#     When I go to the tasks page
#     Then I should be on the login page
