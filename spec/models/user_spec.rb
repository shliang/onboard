require 'spec_helper'

describe User do
  it { should have_many :services }

  let(:user) { FactoryGirl.build(:user) }

  describe "#no_social_auth?" do
    it 'returns true if there are no social serices authentications' do
      expect(user.no_social_auth?).to be true
    end

    it 'returns false if there is at least one social serices authentications' do
      user.services.new
      expect(user.no_social_auth?).to be false
    end
  end

  describe "#email_required?" do
    it 'returns true if there are no services' do
      expect(user.email_required?).to be true
    end

    it 'returns false if there is at least one social services authentication' do
      user.services.new
      expect(user.email_required?).to be false
    end
  end

  describe "#password_required?" do
    it 'returns true if there are no services' do
      expect(user.password_required?).to be true
    end

    it 'returns false if there is at least one social services authentication' do
      user.services.new
      expect(user.password_required?).to be false
    end
  end

  describe '#build_or_update_from_omniauth_info' do
    let(:omniauth_info) { OmniAuth::AuthHash.new }
    let(:list) { [name, ] }

    ['name', 'username', 'nickname', 'location', 'image_url', 'description', 'email'].each do |foo|
      it "sets name if omniauth_info.#{foo} is not blank" do
        user.send("#{foo}=", 'Ken')
        omniauth_info[foo] = 'Rhonda'
        user.build_or_update_from_omniauth_info omniauth_info
        expect(user.method(foo).call).to eql 'Rhonda'
      end

      it "does nothing to #{foo} if omniauth_info.foo is blank" do
        user.send("#{foo}=", 'Ken')
        omniauth_info[foo] = ''
        user.build_or_update_from_omniauth_info omniauth_info
        expect(user.method(foo).call).to eql 'Ken'
      end
    end
  end
end
