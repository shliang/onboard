require 'spec_helper'

describe UsersController, type: :controller do
  describe 'non-authenticated user' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @user.confirm!
      sign_out @user
    end

    describe 'users#profiles' do
      it 'redirects signin with flash message' do
        expect(I18n).to receive(:translate).with(:not_signed_in).and_return( 'this is my test' )

        expect(get :profiles).to redirect_to(new_user_session_path)
        expect(flash[:notice]).to eq 'this is my test'
      end
    end

    describe 'users#profile' do
      it 'redirects signin with flash message' do
        expect(I18n).to receive(:translate).with(:not_signed_in).and_return( 'this is my test' )

        expect(get :profile, id: @user).to redirect_to(new_user_session_path)
        expect(flash[:notice]).to eq 'this is my test'
      end
    end
  end

  describe 'authenticated user' do
    let(:test_users) { [FactoryGirl.create(:user), FactoryGirl.create(:user)] }

    before(:each) do
      @user = FactoryGirl.create(:user)
      @user.confirm!
      sign_in @user
    end

    describe 'users#profiles' do
      it 'sets @users to an array of all users' do
        test_users << @user

        get :profiles
        expect(assigns(:users)).to match_array test_users
      end
    end

    describe 'users#profile' do
      it 'sets @user user matching id' do
        get :profile, id: @user.id
        expect(assigns(:user)).to eq @user
      end
    end
  end
end
