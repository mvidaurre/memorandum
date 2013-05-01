

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
  visit("/groups/#{@group_id}?api_token=#{@api_token}")
end

When(/^I create a memo with:$/) do |table|
  memo = table.rows_hash
  post "/groups/#{@group_id}/memos?api_token=#{@api_token}", :memo => {:title => memo['Title'], :description => memo['Description'], :due_date => memo['Due Date']}
end

Then(/^the members of the group "(.*?)" should receive the memo with title "(.*?)"$/) do |group, title|
  @group = Group.find_by_name(group)
  @group.users.each do |u|
    visit("/users/#{u.id}/groups/#{@group_id}/memos?api_token=#{@api_token}")
    page.should have_content("\"title\":\"#{title}\"")
  end
end

Then(/^the user with email "(.*?)" confirmed that he has read the memo titled "(.*?)"$/) do |user_email, memo_title|
  @memo = Memo.find_by_title(memo_title)
  @user = User.find_by_email(user_email)
  post "/users/#{@user.id}/groups/#{@group_id}/memos/#{@memo.id}/user_read_memos?api_token=#{@api_token}", read: true
end

Then(/^all the members of the group "(.*?)" will see that "(.*?)" people have read the memo with title "(.*?)"$/) do | group, read_number, memo_title|
  @memo = Memo.find_by_title(memo_title)
  @group = Group.find_by_name(group)

  @group.users.each do |u|
    visit("/users/#{u.id}/groups/#{@group.id}/memos/#{@memo.id}?api_token=#{@api_token}")

    page.should have_content("\"user_read_memos_count\":#{read_number}")
  end
end

Then(/^for memo titled "(.*?)" the following users have confirmed reading the memo:$/) do |memo_title, users|
  # table is a Cucumber::Ast::Table
  @memo = Memo.find_by_title(memo_title)
  @group_id = @memo.group.id
  users.hashes.each do |u|
    user = User.find_by_email(u[:email])
    post "/users/#{user.id}/groups/#{@group_id}/memos/#{@memo.id}/user_read_memos?api_token=#{@api_token}", read: true
  end
end
# Edit Memo Title
Given(/^the memo in the Group "(.*?)" is already created with the following fields:$/) do |group_name, table|
  @group_id = Group.find_by_name(group_name).id  
  @user_id= User.find_by_email("dj.vita.09@gmail.com").id  
  memo = table.rows_hash
  post "/groups/#{@group_id}/memos?api_token=#{@api_token}", :memo => {:title => memo['Title'], :description => memo['Description'], :due_date => memo['Due Date']}
  @memo_id = Memo.find_by_title(memo['Title']).id
end

When(/^as an admin I try to edit the Title to "(.*?)"$/) do |new_title|
  put "/users/#{@user_id}/groups/#{@group_id}/memos/#{@memo_id}?api_token=#{@api_token}", :memo => {:title => new_title}

end

Then(/^the memo Title should be changed to "(.*?)"$/) do |new_title|
  visit("/users/#{@user_id}/groups/#{@group_id}/memos/#{@memo_id}?api_token=#{@api_token}")
  page.should have_content(new_title) 
end

#Edit Memo Description
When(/^as an admin I try to edit the Description  to "(.*?)"$/) do |new_description|
  put "/users/#{@user_id}/groups/#{@group_id}/memos/#{@memo_id}?api_token=#{@api_token}", :memo => {:description => new_description}
end

#Edit Memo Due Date
When(/^as an admin I try to edit the Due Date  to "(.*?)"$/) do |new_date|
  put "/users/#{@user_id}/groups/#{@group_id}/memos/#{@memo_id}?api_token=#{@api_token}", :memo => {:due_date => new_date}
end
