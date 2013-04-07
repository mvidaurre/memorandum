Given(/^I am an user$/) do
   @user = User.create(first_name: "Elias", last_name: "Vidaurre", email: "dj.vita.09@gmail.com", password: "password")
end

Given(/^there are some users:$/) do |users|
	users.hashes.each{|u| User.create(u)}
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

