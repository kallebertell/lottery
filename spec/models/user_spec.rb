require 'spec_helper'

describe User do
  before do
    @user = User.new(email: "user@example.com")
  end

  describe "when email format is invalid" do
    
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.foo@bar baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address 
        @user.should_not be_valid
      end 
    end

  end

  describe "when email format is valid" do 
    it "should be valid" do
      addresses = %w[user@foo.COM A+US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid 
      end
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup 
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end
  
    it { should_not be_valid }
  end

end
