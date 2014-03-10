require 'spec_helper'

describe UsersController do
  let(:users) { [FactoryGirl.create(:user), FactoryGirl.create(:user)] }
  describe 'users#profiles returns all users' do
    it 'sets @user to an array of all users' do
      get :profiles
      assigns(:users).should eq(users)
    end
  end
end