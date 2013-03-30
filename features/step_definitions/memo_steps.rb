

Given(/^I belong to the group "(.*?)" with members:$/) do |group, members|
  # table is a Cucumber::Ast::Table
  @group = Group.create(name: group, expiration: Date.new(2013, 04, 29))
  members.hashes.each do |u| 
    usr = User.create(u) 
    Membership.create(group: @group, user: usr, admin:false)
  end
  Membership.create(group: @group, user: @user, admin:true)
  
end

When(/^I select the group "(.*?)"$/) do |group|
  @group_id = Group.find_by_name(group).id  
  visit("/groups/#{@group_id}")
end

When(/^I create a memo with:$/) do |table|
  memo = table.rows_hash
  post "/groups/#{@group_id}/memos", :memo => {:title => memo['Title'], :description => memo['Description'], :due_date => memo['Due Date']}

end

When(/^I send the message to the group "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^the message should be sent to the group "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^the members of the group "(.*?)" should receive the memo$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^the user must confirm that he has read the memo$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^all the members of the group "(.*?)" will see how many people have read the memo$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end
