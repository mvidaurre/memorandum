require 'spec_helper'

describe "memos/edit" do
  before(:each) do
    @memo = assign(:memo, stub_model(Memo,
      :title => "MyString",
      :description => "MyString",
      :group => nil,
      :user => nil
    ))
  end

  it "renders the edit memo form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", memo_path(@memo), "post" do
      assert_select "input#memo_title[name=?]", "memo[title]"
      assert_select "input#memo_description[name=?]", "memo[description]"
      assert_select "input#memo_group[name=?]", "memo[group]"
      assert_select "input#memo_user[name=?]", "memo[user]"
    end
  end
end
