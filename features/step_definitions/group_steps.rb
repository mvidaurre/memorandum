#Creat a new Group

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
  post "/groups?api_token=#{@api_token}", :group => {:name => @group_name, :users => @users, :expiration => @expiration}
end

Then(/^the group "(.*?)" should be created$/) do |group_name|
  visit("/groups?api_token=#{@api_token}")
  page.should have_content(group_name)
end

Then(/^then I should be and admin for the group "(.*?)"$/) do |group_name|
  id = Group.find_by_name(group_name).id  
  visit("/groups/#{id}?api_token=#{@api_token}")
  page.should have_content("\"admin\":true,\"user\":{\"email\":\"dj.vita.09@gmail.com\"")
end

#Edit Group name
Given(/^The group "(.*?)" is already created with the following users:$/) do |group_name, users_group|
   post "/groups?api_token=#{@api_token}", :group => {:name => group_name, :users => users_group.hashes, :expiration => Date.new(2014,1,10)}
   @group_id = Group.find_by_name(group_name).id  
end

When(/^as an admin I try to edit the name to "(.*?)"$/) do |new_group_name|
  put "/groups/#{@group_id}?api_token=#{@api_token}", :group => {:name => new_group_name}    
end

Then(/^the title should be changed to "(.*?)"$/) do |new_group_name|
  visit("/groups/#{@group_id}?api_token=#{@api_token}")
  page.should have_content(new_group_name) 
end

# Edit Expiration Date
When(/^as an admin I try to edit the date to "(.*?)"$/)  do | new_expiration|
  put "/groups/#{@group_id}?api_token=#{@api_token}", :group => {:expiration => new_expiration} 
end

Then(/^the date should be changed to "(.*?)"$/) do |new_expiration|
  visit("/groups/#{@group_id}?api_token=#{@api_token}")
  page.should have_content(new_expiration) 
end

#Add Users
When(/^as an admin I try to add the user:$/) do |member| 
  member.hashes.each{|m| post "/users/#{User.find_by_email(m[:email]).id}/groups/#{@group_id}/memberships?api_token=#{@api_token}", :membership => {admin: m[:admin]}}
end

Then(/^the users of the group should be changed to$/) do |members|
  visit("/groups/#{@group_id}?api_token=#{@api_token}")
  members.hashes.each{|m| page.should have_content(m[:email])}
end

#Remove Users From Group
When(/^as an admin I try to remove the user:$/) do |members|
  members.hashes.each{|m| delete "/users/#{User.find_by_email(m[:email]).id}/groups/#{@group_id}/memberships/1?api_token=#{@api_token}", :membership => {admin: m[:admin]}}
end

#Unauth Edits

When(/^as a user "(.*?)" with password "(.*?)" I try to edit the name to "(.*?)"$/) do |user_email, password, new_group_name|
  post '/users/login', :user => {email: user_email, password: password}
  @api_token_for_user = JSON.parse(last_response.body)["user"]["api_token"]
  assert @api_token_for_user != nil, "API Token was nil JSON: #{last_response.body}" 
  put "/groups/#{@group_id}?api_token=#{@api_token_for_user}", :group => {:name => new_group_name}

end

Then(/^the title should NOT be changed to "(.*?)", should be "(.*?)"$/) do |new_group_name, group_name|
  visit("/groups/#{@group_id}?api_token=#{@api_token_for_user}")
  page.should_not have_content(new_group_name) 
  page.should have_content(group_name) 
end

When(/^as a user "(.*?)" with password "(.*?)" I try to see the group "(.*?)"$/) do |user_email, password, group_name|
  post '/users/login', :user => {email: user_email, password: password}
  @api_token_for_user = JSON.parse(last_response.body)["user"]["api_token"]
  assert @api_token_for_user != nil, "API Token was nil JSON: #{last_response.body}" 
  get "/groups/#{@group_id}?api_token=#{@api_token_for_user}"
end

Then(/^I should receive the error message "(.*?)"$/) do |error_msg|
  expected_message = "{\"error\":\"#{error_msg}\"}"
  assert last_response.body == expected_message , "Error message was JSON: #{last_response.body} and error_msg was expected: #{expected_message}"
end



