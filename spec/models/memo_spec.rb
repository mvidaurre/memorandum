require 'spec_helper'

describe Memo do
  let(:group) { mock_model(Group) }
  let(:user) { mock_model(User) }
  it "create a memo and gets its title" do
  	memo = Memo.create!(
  		user: user, 
  		group: group, 
  		title: "My Memo", 
  		description: "This is a memo for testing", 
  		due_date: Date.new(2013,10,19))
  	expect(memo.title).to eq("My Memo")
  end
  it "validates presence of title, description, due date" do
  	expect(Memo.create(
  		user: user, 
  		group: group, 
  		title: "", 
  		description: "This is a memo for testing", 
  		due_date: Date.new(2013,10,19))).to have(1).error_on(:title)
  	expect(Memo.create(
  		user: user, 
  		group: group, 
  		title: "Other Memo", 
  		description: "", 
  		due_date: Date.new(2013,10,19))).to have(1).error_on(:description)
  	expect(Memo.create(
  		user: user, 
  		group: group, 
  		title: "Other Memo", 
  		description: "This is another memo for testing", 
  		due_date: nil)).to have(1).error_on(:due_date)
  end
end
