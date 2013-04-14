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


#New Scenario

When(/^I give my info:$/) do |user_info|
  post '/users', :user => user_info.rows_hash
end

Then(/^I should be registered as a new user with email "(.*?)" and password "(.*?)" receiving the api token assigned to me$/) do |email, password|
  post '/users/login', :user => {email: "#{email}", password: "#{password}"}
  assert JSON.parse(last_response.body)["user"]["api_token"] != nil, "API Token was nil JSON: #{last_response.body}"
end
