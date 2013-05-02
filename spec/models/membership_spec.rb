require 'spec_helper'

describe Membership do
  let(:group) { mock_model(Group) }
  let(:user) { mock_model(User) }
  it "validates that a user could be member of a group only once" do
  	membership = Membership.create!(user: user, group: group, admin: false)
  	expect(Membership.create(user: user, group: group, admin: true)).to have(1).error_on(:user_id)
  end
end
