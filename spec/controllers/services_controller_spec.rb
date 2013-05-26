require 'spec_helper'

describe ServicesController do

  before :each do
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe "GET 'authenticate'" do
    it "returns http success" do
      get 'authenticate'
      response.should be_success
    end
  end

  # describe "GET 'destroy'" do
  #   it "returns http success" do
  #     get 'destroy'
  #     response.should be_success
  #   end
  # end

  # describe "GET 'failure'" do
  #   it "returns http success" do
  #     get 'failure'
  #     response.should be_success
  #   end
  # end

  # describe "GET 'index'" do
  #   it "returns http success" do
  #     get 'index'
  #     response.should be_success
  #   end
  # end

  # describe "GET 'twitter'" do
  #   it "returns http success" do
  #     get 'twitter'
  #     response.should be_success
  #   end
  # end

  # describe "GET 'facebook'" do
  #   it "returns http success" do
  #     get 'facebook'
  #     response.should be_success
  #   end
  # end

end
