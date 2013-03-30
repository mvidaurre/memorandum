require 'spec_helper'

describe "memos/new" do
  before(:each) do
    assign(:memo, stub_model(Memo,
      :title => "MyString",
      :description => "MyString",
      :group => nil,
      :user => nil
    ).as_new_record)
  end

  it "renders new memo form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", memos_path, "post" do
      assert_select "input#memo_title[name=?]", "memo[title]"
      assert_select "input#memo_description[name=?]", "memo[description]"
      assert_select "input#memo_group[name=?]", "memo[group]"
      assert_select "input#memo_user[name=?]", "memo[user]"
    end
  end
end
