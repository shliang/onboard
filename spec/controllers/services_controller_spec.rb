require 'spec_helper'

describe ServiceController do

  describe "GET 'create'" do
    it "returns http success" do
      get 'create'
      response.should be_success
    end
  end

  describe "GET 'destroy'" do
    it "returns http success" do
      get 'destroy'
      response.should be_success
    end
  end

  describe "GET 'failure'" do
    it "returns http success" do
      get 'failure'
      response.should be_success
    end
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'twitter'" do
    it "returns http success" do
      get 'twitter'
      response.should be_success
    end
  end

  describe "GET 'facebook'" do
    it "returns http success" do
      get 'facebook'
      response.should be_success
    end
  end

end
