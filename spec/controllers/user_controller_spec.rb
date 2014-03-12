require 'spec_helper'

describe UsersController do

  describe 'non-authenticated user' do

    before(:each) do
      @user = FactoryGirl.create(:user)
      @user.confirm!
      sign_out @user
    end

    describe 'users#profiles' do
      # let(:I18n) { double("I18n") }

      it 'redirects signin with flash message' do

        #### TODO: should decuple test from value in en.yml
        # puts "~~~~~~~~~~~~~ I18n.t(:not_signed_in)  #{I18n.t(:not_signed_in)}"
        # # I18n.stub(:not_signed_in) { 'this is my test' }
        # allow(I18n.t).to receive(:not_signed_in) { 'this is my test' }
        # I18n.stub(t: :not_signed_in) { "this is my test" }

        # puts ">>>>>>>>>>>>> I18n.t(:not_signed_in)  #{I18n.t(:not_signed_in)}"

        expect(get :profiles).to redirect_to(new_user_session_path)
        flash[:notice].should eq 'Sorry. Gotta sign in to see that. Please sign in.'
      end

    describe 'users#profile' do
      it 'redirects signin with flash message' do
        expect(get :profile, id: @user.id).to redirect_to(new_user_session_path)
        flash[:notice].should eq 'Sorry. Gotta sign in to see that. Please sign in.'
      end
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
        assigns(:users).should =~ test_users
      end
    end

    describe 'users#profile' do
      it 'sets @user user matching id' do
        get :profile, id: @user.id
        assigns(:user).should == @user
      end
    end
  end

end
