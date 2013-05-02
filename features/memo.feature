Feature: Create Memo
  In order to communicate a task to be done
  As a User
  I want to create a memo to be sent to the Group
  Background:
    Given I am an user
    And I belong to the group "My Group" with members:
      | first_name | last_name | email               | password | password_confirmation |
      | Hugo       | Fernandez | hf@me.com           | 09876543 | 09876543              |
      | Marisela   | Rojo      | marired@outlook.com | asdasdsa | asdasdsa              |
      | Tomas      | Colsa     | tcolsa@rm.com       | 8888777  | 8888777               |
      | Brayan     | Acosta    | bracost@hotmail.com  | 45wer!   | 45wer!                |
      | Enrique    | Arias     | earias1001@gmail.com | 8888777  | 8888777               |

  Scenario: Send a Memo read by one user
    When I select the group "My Group"
    And I create a memo with:
      | Title       | tarea                |
      | Description | Hacer los ejercicios |
      | Due Date    | 2013-05-02           |
    Then the members of the group "My Group" should receive the memo with title "tarea"
    And the user with email "hf@me.com" confirmed that he has read the memo titled "tarea"
    And all the members of the group "My Group" will see that "1" people have read the memo with title "tarea"
  
  
  Scenario: Send a Memo read by multiple users
    When I select the group "My Group"
    And I create a memo with:
      | Title       | reunion              |
      | Description | Junta a ls 3pm       |
      | Due Date    | 2013-09-02           |
    Then the members of the group "My Group" should receive the memo with title "reunion"
    And for memo titled "reunion" the following users have confirmed reading the memo:
      | email                |
      | tcolsa@rm.com        |
      | bracost@hotmail.com  |
      | earias1001@gmail.com |
    And all the members of the group "My Group" will see that "3" people have read the memo with title "reunion"
  
  Scenario: Edit a Memo Title
    Given the memo in the Group "My Group" is already created with the following fields:
      | Title       | reunion              |
      | Description | Junta a ls 3pm       |
      | Due Date    | 2013-09-02           |
    When as an admin I try to edit the Title to "Junta urgente"  
    Then the memo Title should be changed to "Junta urgente"   

  Scenario: Edit a Memo Description
    Given the memo in the Group "My Group" is already created with the following fields:
      | Title       | reunion              |
      | Description | Junta a ls 3pm       |
      | Due Date    | 2013-09-02           |
    When as an admin I try to edit the Description  to "Junta a las 5pm"  
    Then the memo Title should be changed to "Junta a las 5pm"  

  Scenario: Edit a Memo Due Date
    Given the memo in the Group "My Group" is already created with the following fields:
      | Title       | reunion              |
      | Description | Junta a ls 3pm       |
      | Due Date    | 2013-09-02           |
    When as an admin I try to edit the Due Date  to "2013-09-05"  
    Then the memo Title should be changed to "2013-09-05"    
