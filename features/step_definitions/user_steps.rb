#Register a new user
Given(/^I am an user$/) do
  post '/users', :user => {first_name: "Elias", last_name: "Vidaurre", email: "dj.vita.09@gmail.com", password: "password", password_confirmation: "password"}
  post '/users/login', :user => {email: "dj.vita.09@gmail.com", password: "password"}
  @api_token = JSON.parse(last_response.body)["user"]["api_token"]
  assert @api_token != nil, "API Token was nil JSON: #{last_response.body}"
end

Given(/^there are some users:$/) do |users|
	users.hashes.each do |u| 
    post '/users', :user => u
    #assert last_response.ok?, "last_response error: #{last_response.errors} "
  end
end

When(/^I give my info:$/) do |user_info|
  post '/users', :user => user_info.rows_hash
end

Then(/^I should be registered as a new user with email "(.*?)" and password "(.*?)" receiving the api token assigned to me$/) do |email, password|
  post '/users/login', :user => {email: "#{email}", password: "#{password}"}
  assert JSON.parse(last_response.body)["user"]["api_token"] != nil, "API Token was nil JSON: #{last_response.body}"
end

#Already Registered User trying to login Scenario

When(/^I give my login info:$/) do |user_info|
  post '/users/login', :user => user_info.rows_hash
end
Then(/^I should be logged in receiving the api token assigned to me$/) do
  assert JSON.parse(last_response.body)["user"]["api_token"] != nil, "API Token was nil JSON: #{last_response.body}"
end

#Not registered user trying to login
Given(/^There are no users registered$/) do
  User.delete_all
end

Then(/^I should receive an error message$/) do
  assert JSON.parse(last_response.body)["error"] == "USER NOT FOUND OR INCORRECT PASSWORD", "Error was different JSON: #{last_response.body}"
end

Then(/^there should be no token assigned to me$/) do
  expected_message = "{\"error\":\"USER NOT FOUND OR INCORRECT PASSWORD\"}"
  assert last_response.body == expected_message , "API Token was JSON: #{last_response.body} and expected_message was: #{expected_message}"
end


