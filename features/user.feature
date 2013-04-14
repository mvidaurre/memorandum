Feature: Create a Group by an admin
  In order to have users create, edit and receive memos.
  Admins should be able to create groups of users.

  Scenario: Create a new group
    Given I am an user 
    And there are some users:
      | first_name | last_name | email               | password | password_confirmation |
      | Hugo       | Fernandez | hf@me.com           | 09876543 | 09876543              |
      | Marisela   | Rojo      | marired@outlook.com | asdasdsa | asdasdsa              |
      | Tomas      | Colsa     | tcolsa@rm.com       | 8888777  | 8888777               |

    When I assign the name "My Group" to the group
    And I select the users or admins who will be in the group:
      | email                | admin |
      | hf@me.com            | false |
      | tcolsa@rm.com        | true  |
      | dj.vita.09@gmail.com | true  |

    And if it is neccesary an expiration date
    And save the changes
    And the group "My Group" should be created
    And then I should be and admin for the group "My Group"

Scenario: Create a new user

  When I give my info:
      | first_name            | Vita               |
      | last_name             | Vidaurre           |
      | email                 | a01221612@itesm.mx |
      | password              | 36450981           |
      | password_confirmation | 36450981           |
  Then I should be registered as a new user with email "a01221612@itesm.mx" and password "36450981" receiving the api token assigned to me



