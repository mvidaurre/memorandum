require 'spec_helper'

describe Group do
  it "creates a group and checks its last name" do
  	my_group = Group.create!(name: "My Group", expiration: Date.new(2013,5,1))
  	expect(my_group.name).to eq("My Group")
  end
  it "validates presence of name and expiration" do
  	expect(Group.create(name: "", expiration: Date.new(2013,5,1))).to have(1).error_on(:name)
  	expect(Group.create(name: "My Group", expiration: nil)).to have(1).error_on(:expiration)
  end
  it "validates that expiration is a Date" do
  	my_group = Group.create!(name: "My Group", expiration: Date.new(2013,5,1))
  	expect(my_group.expiration).to be_a(Date)
  end
end
