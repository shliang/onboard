class Service < ActiveRecord::Base
  belongs_to :user

  def build_or_update_from_omniauth(provider, uid, credentials, omniauth)
    raise "no user" if self.user.nil?  ### we assume it belongs to a user

    case provider
    when 'facebook'
      update_attributes(provider: provider, uid: uid, token: credentials.token, expires_at: credentials.expires_at,  expires: credentials.expires, info: omniauth.extra.raw_info)
    when 'twitter'
      update_attributes(provider: provider, uid: uid, token: credentials.token, expires_at: credentials.expires_at,  expires: credentials.expires)
    else
      ## this should not happen
      logger.info "~~~~~~~~~~~~~~~~~ Service#build_or_update_from_omniauth  FAILURE: who is this provider? '" + provider +"'"
    end

    logger.info "~~~~~~~~~~~~~~~~~ Service#build_or_update_from_omniauth self #{ self.inspect } "

    save
  end
end
