Feature: Create Memo
  In order to communicate a task to be done
  As a User
  I want to create a memo to be sent to the Group

  Scenario: Send a Memo
    Given I am an user
    And I belong to the group "My Group" with members:
      | first_name | last_name | email               | password |
      | Hugo       | Fernandez | hf@me.com           | 09876543 |
      | Marisela   | Rojo      | marired@outlook.com | asdasdsa |
      | Tomas      | Colsa     | tcolsa@rm.com       | 8888777  | 
    When I select the group "My Group"
    And I create a memo with:
      | Title       | tarea                |
      | Description | Hacer los ejercicios |
      | Due Date    | 2013-05-02           |
    Then the members of the group "My Group" should receive the memo with title "tarea"
    And the user with email "hf@me.com" confirmed that he has read the memo titles "tarea"
    And all the members of the group "My Group" will see how many people have read the memo
  
  
  
  
  
