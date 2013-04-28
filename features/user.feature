Feature: User management
  In order to have login or register to the system.
  Users should be able to register as a user and login to the system.

Scenario: Register a new user

  When I give my info:
      | first_name            | Vita               |
      | last_name             | Vidaurre           |
      | email                 | a01221612@itesm.mx |
      | password              | 36450981           |
      | password_confirmation | 36450981           |
  Then I should be registered as a new user with email "a01221612@itesm.mx" and password "36450981" receiving the api token assigned to me

  Scenario: Login for an existing user
    Given I am an user
    When I give my login info:
      | email    | dj.vita.09@gmail.com|
      | password | password           |
 
    Then I should be logged in receiving the api token assigned to me

  Scenario: Login for a non-registered user
    Given There are no users registered
    When I give my login info:

      | email    | bgates@microsoft.com |
      | password | riches           |
 
    Then I should receive an error message 
    And there should be no token assigned to me
