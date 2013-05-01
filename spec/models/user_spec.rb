require 'spec_helper'

describe User do
	it "creates a new user and checks its last name" do
  	lindeman = User.create!(first_name: "Andy", 
  		last_name: "Lindeman", 
  		email: "al@gmail.com", 
  		password: "12345678", 
  		password_confirmation: "12345678")
  	expect(lindeman.last_name).to eq("Lindeman")
  end
  it "validates that the password and password_confirmation are the same" do
  	expect(User.create(
  		first_name: "Andy", 
  		last_name: "Lindeman", 
  		email: "al@gmail.com", 
  		password: "12345678", 
  		password_confirmation: "1235678")).to have(1).error_on(:password)
  end
   it "validates presence of email, first name, last name, password, password_confirmation" do
  	expect(User.create(
  		first_name: "", 
  		last_name: "Lindeman", 
  		email: "al@gmail.com", 
  		password: "12345678", 
  		password_confirmation: "12345678")).to have(1).error_on(:first_name)
  	 expect(User.create(
  		first_name: "Robert", 
  		last_name: "", 
  		email: "al@gmail.com", 
  		password: "12345678", 
  		password_confirmation: "12345678")).to have(1).error_on(:last_name)
  	 expect(User.create(
  		first_name: "Robert", 
  		last_name: "Becker", 
  		email: "", 
  		password: "12345678", 
  		password_confirmation: "12345678")).to have(2).error_on(:email)
  	 expect(User.create(
  		first_name: "Robert", 
  		last_name: "Becker", 
  		email: "rb@me.it", 
  		password: "", 
  		password_confirmation: "12345678")).to have(2).error_on(:password)
  end
  it "validates email format" do
  	expect(User.create(
  		first_name: "Andy", 
  		last_name: "Lindeman", 
  		email: "al@gmail.com.", 
  		password: "12345678", 
  		password_confirmation: "1235678")).to have(1).error_on(:email)
  	 expect(User.create(
  		first_name: "Andy", 
  		last_name: "Lindeman", 
  		email: "al@@gmail.com", 
  		password: "12345678", 
  		password_confirmation: "1235678")).to have(1).error_on(:email)
  end
  it "creates an user and check that an api_token was assigned to the user" do
  	lindeman = User.create!(first_name: "Andy", 
  		last_name: "Lindeman", 
  		email: "al@gmail.com", 
  		password: "12345678", 
  		password_confirmation: "12345678")
  	expect(lindeman.api_token).not_to eq(nil)
  	expect(lindeman.api_token.length).to eq(32)
  end
end
