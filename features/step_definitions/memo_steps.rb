

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

Then(/^the members of the group "(.*?)" should receive the memo with title "(.*?)"$/) do |group, title|
  @group = Group.find_by_name(group)
  @group.users.each do |u|
    visit("/users/#{u.id}/groups/#{@group_id}/memos")
    page.should have_content("\"title\":\"#{title}\"")
  end
end

Then(/^the user with email "(.*?)" confirmed that he has read the memo titles "(.*?)"$/) do |user_email, memo_title|
  @memo = Memo.find_by_title(memo_title)
  @user = User.find_by_email(user_email)
  post "/users/#{@user.id}/groups/#{@group_id}/memos/#{@memo.id}/user_read_memos", read: true
end

Then(/^all the members of the group "(.*?)" will see how many people have read the memo$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end
