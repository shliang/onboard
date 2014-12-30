class User < ActiveRecord::Base
  ROLES = [:admin]
  devise  :confirmable, :database_authenticatable, :lockable, :omniauthable,
          :registerable, :rememberable, :trackable, :validatable,
          :omniauth_providers => [:facebook, :twitter]
          # other Devise modules--  :recoverable, :timeoutable,

  has_many :services

  def email_required?
    super && no_social_auth?
  end

  def password_required?
    super && no_social_auth?
  end

  def build_or_update_from_omniauth_info(omniauth_info)
    self.name        = omniauth_info.name        if !omniauth_info.name.blank?
    self.username    = omniauth_info.username    if !omniauth_info.username.blank?
    self.nickname    = omniauth_info.nickname    if !omniauth_info.nickname.blank?
    self.location    = omniauth_info.location    if !omniauth_info.location.blank?
    self.image_url   = omniauth_info.image_url   if !omniauth_info.image_url.blank?
    self.description = omniauth_info.description if !omniauth_info.description.blank?
    self.email       = omniauth_info.email       if !omniauth_info.email.blank?
    logger.info "~~~~~~~~~~~~~~~~~ user#from_omniauth  user: " + self.to_yaml

    ## THIS HAS __NOT__ BEEN SAVED
  end

  def no_social_auth?
    services.empty?
  end

  def has_provider?(provider)
    services.map(&:provider).include? provider.to_s
  end

  def admin?
    self.role == 'admin'
  end
end
