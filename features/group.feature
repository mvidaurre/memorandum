Feature: Manage a Group by an admin
  In order to have users create, edit and receive memos.
  Admins should be able to create groups of users.

  Background: 
    Given I am an user 
    And there are some users:
      | first_name | last_name | email               | password | password_confirmation |
      | Hugo       | Fernandez | hf@me.com           | 09876543 | 09876543              |
      | Marisela   | Rojo      | marired@outlook.com | asdasdsa | asdasdsa              |
      | Tomas      | Colsa     | tcolsa@rm.com       | 8888777  | 8888777               |

  Scenario: Create a new group
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

  Scenario: Edit a Group Title
    Given The group "My Group" is already created with the following users:
      | email                | admin |
      | hf@me.com            | false |
      | marired@outlook.com  | true  |
      | dj.vita.09@gmail.com | true  |  
    When as an admin I try to edit the name to "Vita's Group"
    Then the title should be changed to "Vita's Group"

  Scenario: Edit an Expiration Date
    Given The group "My Group" is already created with the following users:
      | email                | admin |
      | hf@me.com            | false |
      | marired@outlook.com  | true  |
      | dj.vita.09@gmail.com | true  |  
    When as an admin I try to edit the date to "2014-02-28"
    Then the date should be changed to "2014-02-28"  
