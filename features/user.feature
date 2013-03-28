Feature: Create a Group by an admin
  In order to have users create, edit and receive memos.
  Admins should be able to create groups of users.

  Scenario: Create a new group
    Given I am an user 
    And there are some users:
    	| first_name | last_name | email | password|
    	| Hugo | Fernandez | hf@me.com| 09876543|
    	| Marisela | Rojo | marired@outlook.com| asdasdsa|
    	| Tomas | Colsa | tcolsa@rm.com | 8888777|
    
    When I need to organize them into a group
    And I tap on "Create a Group"
    And I assign the name "My Group" to the group
    And I select the users or admins who will be in the group
    And if it is neccesary an expiration date
	 And save the changes
	 Then the group "My Group" should be created
	 And then I should be and admin for the group "My Group"
