class Service < ActiveRecord::Base
  belongs_to :user

	serialize :info, Hash
  attr_accessible :provider, :uid, :token, :secret, :info

  def provider_name
    if provider == 'open_id'
      "OpenID"
    else
      provider.titleize
    end
  end
end