require 'spec_helper'

describe User do
  before(:each) do
    @attr = { :first_name => "John", :last_name => "Doe", :email => "john.doe@example.com" }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

  it "should require a first_name and last_name" do
    no_name_user = User.new(@attr.merge(:first_name => "",:last_name => "")) 
    no_name_user.should_not be_valid
  end
  
  it "should require an email address" do
    no_email_user = User.new(@attr.merge(:email => "")) 
    no_email_user.should_not be_valid
  end

  it "should reject first name that are too long" do
    long_name = "a" * 51 
    long_first_name_user = User.new(@attr.merge(:first_name => long_name))
    long_first_name_user.should_not be_valid
  end
  
  it "should reject last name that are too long" do
    long_name = "b" * 51
    long_last_name_user = User.new(@attr.merge(:last_name => long_name))
    long_last_name_user.should_not be_valid
  end
  
  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end
  
  it "should reject duplicate email addresses" do
    # Put a user with given email address into the database.
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
  
  it "should reject duplicate email addresses identical up to case" do
    # Put a user with given email address into the database.
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

end
