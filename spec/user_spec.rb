require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
      it 'exists' do
      @newUser = User.new(:name => 'name', :password=> 'password1', :password_confirmation => 'password1', :email => 'user@email.com') 
      @newUser.save!
      expect(@newUser.id).to be_present
    end

    it 'has a name' do
      @newUser = User.new(:name => nil, :password=> 'password1', :password_confirmation => 'password1', :email => 'user@email.com') 
      @newUser.valid?
      expect(@newUser.errors.full_messages).to include("Name can't be blank") 
    end

    it 'has a password' do
      @newUser = User.new(:name => 'name', :password=> nil, :password_confirmation => 'password1', :email => 'user@email.com') 
      @newUser.valid?
      expect(@newUser.errors.full_messages).to include("Password can't be blank") 
    end

    it 'has a password confirmation' do
      @newUser = User.new(:name => 'name', :password=> 'password1', :password_confirmation => nil, :email => 'user@email.com') 
      @newUser.valid?
      expect(@newUser.errors.full_messages).to include("Password confirmation can't be blank") 
    end

    it 'password is between 6 - 20 chars' do
      @newUser = User.new(:name => 'name', :password=> '123', :password_confirmation => '123', :email => 'user@email.com') 
      @newUser.valid?
      expect(@newUser.errors.full_messages).to include("Password is too short (minimum is 6 characters)") 
    end


    it 'has an email' do
      @newUser = User.new(:name => 'name', :password=> 'password1', :password_confirmation => 'password1', :email => nil) 
      @newUser.valid?
      expect(@newUser.errors.full_messages).to include("Email can't be blank") 
    end

    it 'email is unique' do
      @newUser = User.new(:name => 'name', :password=> 'password1', :password_confirmation => 'password1', :email => 'user@email.com') 
      @newUser2 = User.new(:name => 'name2', :password=> 'password2', :password_confirmation => 'password2', :email => 'USER@email.com') 
      @newUser.save!
      @newUser2.valid?
      expect(@newUser2.errors.full_messages).to include("Email has already been taken") 
    end
  end

  describe '.authenticate_with_credentials' do
    it 'returns user with right info' do
      @user = User.new(:name => 'name', :password=> 'password1', :password_confirmation => 'password1', :email => 'user@email.com')
      @user.save!
      expect(@user.authenticate_with_credentials('user@email.com', 'password1')).to be_truthy
    end

    it 'checks for right email' do
      @user = User.new(:name => 'name', :password=> 'password1', :password_confirmation => 'password1', :email => 'user@email.com')
      @user.save!
      expect(@user.authenticate_with_credentials('wrong@email.com', 'password1')).to be_nil
    end

    it 'email is not case sensitive' do
      @user = User.new(:name => 'name', :password=> 'password1', :password_confirmation => 'password1', :email => 'user@email.com')
      @user.save!
      expect(@user.authenticate_with_credentials('USER@email.com', 'password1')).to be_truthy
    end
    
    it 'trailing and leading spaces email are valid' do
      @user = User.new(:name => 'name', :password=> 'password1', :password_confirmation => 'password1', :email => 'user@email.com')
      @user.save!
      expect(@user.authenticate_with_credentials('  USER@email.com   ', 'password1')).to be_truthy
    end

    it 'checks for right password' do
      @user = User.new(:name => 'name', :password=> 'password1', :password_confirmation => 'password1', :email => 'user@email.com')
      @user.save!
      expect(@user.authenticate_with_credentials('user@email.com', 'Wrongpassword1')).to be_nil
    end
  end
end

