require 'spec_helper'

describe "user_read_memos/index" do
  before(:each) do
    assign(:user_read_memos, [
      stub_model(UserReadMemo,
        :read => "",
        :user => nil,
        :memo => nil
      ),
      stub_model(UserReadMemo,
        :read => "",
        :user => nil,
        :memo => nil
      )
    ])
  end

  it "renders a list of user_read_memos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
