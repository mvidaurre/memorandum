require 'spec_helper'

describe Group do
	let(:owner) { mock_model(User) }
  it "creates a group and checks its last name" do
  	my_group = Group.create!(name: "My Group", expiration: Date.new(2013,5,1), owner: owner)
  	expect(my_group.name).to eq("My Group")
  end
  it "validates presence of name and expiration" do
  	expect(Group.create(name: "", expiration: Date.new(2013,5,1), owner: owner)).to have(1).error_on(:name)
  	expect(Group.create(name: "My Group", expiration: nil, owner: owner)).to have(1).error_on(:expiration)
  end
  it "validates that expiration is a Date" do
  	my_group = Group.create!(name: "My Group", expiration: Date.new(2013,5,1), owner: owner)
  	expect(my_group.expiration).to be_a(Date)
  end
  it "validates that has an owner" do
  	my_group = Group.create!(name: "My Group", expiration: Date.new(2013,5,1), owner: owner)
  	expect(my_group.owner).to be_a(User)
  end
end
