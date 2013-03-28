Given(/^I am an user$/) do
   @user = FactoryGirl.build(:user)
end

Given(/^there are some users:$/) do |users|
	users.hashes.each{|u| FactoryGirl.build(:user, u)}
end


When(/^I need to organize them into a group$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I tap on "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

When(/^I assign the name "(.*?)" to the group$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

When(/^I select the users or admins who will be in the group$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^if it is neccesary an expiration date$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^save the changes$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^the group "(.*?)" should be created$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^then I should be and admin for the group "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

