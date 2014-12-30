require 'spec_helper'

describe ServicesController, type: :controller do
  #### TODO: Existing User problem
  # Given user is signed in
  # When user authenticates with Facebook
  # And Facebook account is associated with a different user
  # Then WHAT HAPPENS???


  before(:each) do
    request.env["devise.mapping"] = Devise.mappings[:user]
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
  end

  describe 'existing user' do
    login_user

    describe 'new authentication' do
      it 'adds service to already existing user' do
        expect( Service.count ).to eql 0
        expect( User.count ).to eql 1

        post :facebook

        expect( Service.count ).to eql 1
        expect( User.count ).to eql 1
      end
    end

    describe 'reauthenticate' do
      it 'logins already existing user with their service' do
        service = FactoryGirl.create(:service, user: @user)
        service.uid = request.env["omniauth.auth"].uid
        service.provider = request.env["omniauth.auth"].provider
        service.save

        expect( Service.count ).to eql 1
        expect( User.count ).to eql 1

        post :facebook

        expect( Service.count ).to eql 1
        expect( User.count ).to eql 1
      end
    end

  end

  describe 'new user' do
    describe 'new authentication' do
      it 'creates a new facebook user and new service' do
        expect( Service.count ).to eql 0
        expect( User.count ).to eql 0

        post :facebook

        expect( Service.count ).to eql 1
        expect( User.count ).to eql 1
      end

      it 'creates a new twitter user and new service' do
        request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
        expect( Service.count ).to eql 0
        expect( User.count ).to eql 0

        post :twitter

        expect( Service.count ).to eql 1
        expect( User.count ).to eql 1
      end
    end
  end
end
