require 'spec_helper'

describe User do
	it "creates a new user and checks its last name" do
  		lindeman = User.create!(first_name: "Andy", last_name: "Lindeman", email: "al@gmail.com", password: "12345678")
  		expect(lindeman.last_name).to eq("Lindeman")
   end
end
