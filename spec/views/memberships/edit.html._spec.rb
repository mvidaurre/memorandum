require 'spec_helper'

describe "memberships/edit" do
  before(:each) do
    @membership = assign(:membership, stub_model(Membership))
  end

  it "renders the edit membership form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", membership_path(@membership), "post" do
    end
  end
end
