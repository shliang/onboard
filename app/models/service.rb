class Service < ActiveRecord::Base
  belongs_to :user

	serialize :info, Hash
  attr_accessible :provider, :uid, :token, :secret, :info, :expires_at, :expires


  def self.build_from_omniauth(user, provider, uid, credentials, omniauth)

    service = Service.find_by_provider_and_uid(provider, uid)    
    service ||= user.services.new

    case provider
    when 'twitter'
      service.update_attributes(provider: provider, uid: uid, token: credentials.token, secret: credentials.secret, info: omniauth.extra.raw_info)
      
    when 'facebook'
      service.update_attributes(provider: provider, uid: uid, token: credentials.token, expires_at: credentials.expires_at,  expires: credentials.expires, info: omniauth.extra.raw_info)

    else
      ## this should not happen
      logger.info "~~~~~~~~~~~~~~~~~ ServicesController#build_from_omniauth  FAILURE: who is this provider? '" + provider +"'"
    end
    logger.info "~~~~~~~~~~~~~~~~~ ServicesController#build_from_omniauth  services: " + service.to_yaml
    service
  end



  def provider_name
    if provider == 'open_id'
      "OpenID"
    else
      provider.titleize
    end
  end
end