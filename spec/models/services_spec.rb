require 'spec_helper'

describe Service do
  describe '#build_or_update_from_omniauth' do
    it 'raises "no user" if user is nil' do
      service = Service.new
      expect{service.build_or_update_from_omniauth(1,2,3,4)}.to raise_error "no user"
    end

    describe 'for provider facebook' do
      let(:user) { FactoryGirl.create :user }

      it 'sets provider, uid and token' do
        s = user.services.new
        raw_info = Hashie::Mash.new( {bio: "If people speak of me, do I exist?"} )

        credentials =  Hashie::Mash.new
        credentials.token = 'a_token'
        credentials.expires_at = '2016'
        credentials.expires = true

        omniauth =  Hashie::Mash.new
        omniauth.extra = Hashie::Mash.new
        omniauth.extra.raw_info = raw_info

        s.build_or_update_from_omniauth('facebook', '100001501410086' , credentials, omniauth)

        expect(s.provider).to eql 'facebook'
        expect(s.uid).to eql '100001501410086'
        expect(s.token).to eql 'a_token'
        expect(s.expires_at).to eql '2016'
        expect(s.expires).to be true
        expect(s.info).to eql raw_info
      end
    end
  end
end
