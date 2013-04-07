Feature: Create a Group by an admin
  In order to have users create, edit and receive memos.
  Admins should be able to create groups of users.

  Scenario: Create a new group
    Given I am an user 
    And there are some users:
      | first_name | last_name | email               | password |
      | Hugo       | Fernandez | hf@me.com           | 09876543 |
      | Marisela   | Rojo      | marired@outlook.com | asdasdsa |
      | Tomas      | Colsa     | tcolsa@rm.com       | 8888777  |  
    When I assign the name "My Group" to the group
    And I select the users or admins who will be in the group:
      | email             | admin |
      | hf@me.com         | false |
      | tcolsa@rm.com     | true  |
      | dj.vita.09@gmail.com | true  |
    And if it is neccesary an expiration date
    And save the changes
    And the group "My Group" should be created
    And then I should be and admin for the group "My Group"
