#Creat a new Group
Given(/^I am an user$/) do
  post '/users', :user => {first_name: "Elias", last_name: "Vidaurre", email: "dj.vita.09@gmail.com", password: "password", password_confirmation: "password"}
end

Given(/^there are some users:$/) do |users|
	users.hashes.each{|u| post '/users', :user => u}
end

When(/^I assign the name "(.*?)" to the group$/) do |group_name|
  @group_name = group_name
end

When(/^I select the users or admins who will be in the group:$/) do |users|
  @users = users.hashes
end

When(/^if it is neccesary an expiration date$/) do
  @expiration = Date.new(2014,12,10)
end

When(/^save the changes$/) do
  post '/groups', :group => {:name => @group_name, :users => @users, :expiration => @expiration}
end

Then(/^the group "(.*?)" should be created$/) do |group_name|
  visit('/groups')
  page.should have_content(group_name)
end

Then(/^then I should be and admin for the group "(.*?)"$/) do |group_name|
  id = Group.find_by_name(group_name).id  
  visit("/groups/#{id}")
  page.should have_content("\"admin\":true,\"user\":{\"email\":\"dj.vita.09@gmail.com\"")
end

#Edit Group name
Given(/^The group "(.*?)" is already created with the following users:$/) do |group_name, users_group|
   post '/groups', :group => {:name => group_name, :users => users_group.hashes, :expiration => Date.new(2014,1,10)}
   @group_id = Group.find_by_name(group_name).id  
end

When(/^as an admin I try to edit the name to "(.*?)"$/) do |new_group_name|
  @user_id= User.find_by_email("dj.vita.09@gmail.com").id  
  put "/users/#{@user_id}/groups/#{@group_id}", :group => {:name => new_group_name}    
end

Then(/^the title should be changed to "(.*?)"$/) do |new_group_name|
  visit("/users/#{@user_id}/groups/#{@group_id}")
  page.should have_content(new_group_name) 
end

# Edit Expiration Date
When(/^as an admin I try to edit the date to "(.*?)"$/)  do | new_expiration|
  @user_id= User.find_by_email("dj.vita.09@gmail.com").id  
  put "/users/#{@user_id}/groups/#{@group_id}", :group => {:expiration => new_expiration} 
end

Then(/^the date should be changed to "(.*?)"$/) do |new_expiration|
  visit("/users/#{@user_id}/groups/#{@group_id}")
  page.should have_content(new_expiration) 
end

#Add Users
When(/^as an admin I try to add the user:$/) do |members| 
  members.hashes.each{|m| post "/users/#{User.find_by_email(m[:email]).id}/groups/#{@group_id}/memberships", :membership => {admin: m[:admin]}}

end

Then(/^the users of the group should be changed to$/) do |members|

  visit("/groups/#{@group_id}")
  members.hashes.each{|m| page.should have_content(m[:email])}

end

#Remove Users From Group
When(/^as an admin I try to remove the user:$/) do |members|

  members.hashes.each{|m| delete "/users/#{User.find_by_email(m[:email]).id}/groups/#{@group_id}/memberships/1", :membership => {admin: m[:admin]}}
end


