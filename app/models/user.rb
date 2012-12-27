class User < ActiveRecord::Base
  has_many :services 

  # Include default devise modules. 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :lockable, :timeoutable, :omniauthable
         # Others available are:
         #   :confirmable, :token_authenticatable,
         
  # DEVISE EXPLAINATIONS
         # Database Authenticatable: encrypts and stores a password in the database to validate the authenticity of a user while signing in. The authentication can be done both through POST requests or HTTP Basic Authentication.
         # Token Authenticatable: signs in a user based on an authentication token (also known as "single access token"). The token can be given both through query string or HTTP Basic Authentication.
         # Omniauthable: adds Omniauth (https://github.com/intridea/omniauth) support;
         # Confirmable: sends emails with confirmation instructions and verifies whether an account is already confirmed during sign in.
         # Recoverable: resets the user password and sends reset instructions.
         # Registerable: handles signing up users through a registration process, also allowing them to edit and destroy their account.
         # Rememberable: manages generating and clearing a token for remembering the user from a saved cookie.
         # Trackable: tracks sign in count, timestamps and IP address.
         # Timeoutable: expires sessions that have no activity in a specified period of time.
         # Validatable: provides validations of email and password. It's optional and can be customized, so you're able to define your own validations.
         # Lockable: locks an account after a specified number of failed sign-in attempts. Can unlock via email or after a specified time period.

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :admin, :username, :nickname

  def admin?
  	self.admin
  end
  
  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end
  
  def email_required?
    services.empty?
  end
  
  
  def password_required?
    super && services.empty?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end
  
  
  ###
  ##  Set up User from Omniauth
  ###
  def self.build_from_omniauth(user, omniauth_info)
    user ||= User.new
        
    user.name = omniauth_info.name if user.name.blank?
    user.username    = omniauth_info.nickname    if user.username.blank?
    user.nickname    = omniauth_info.nickname    if user.nickname.blank?
    user.location    = omniauth_info.location    if user.location.blank?
    user.image_url   = omniauth_info.image       if user.image_url.blank?
    user.description = omniauth_info.description if user.description.blank?
    user.email       = omniauth_info.email       if user.email.blank? 
    logger.info "~~~~~~~~~~~~~~~~~ user#from_omniauth  user: " + user.to_yaml
    user
  end
  
  
  ###
  ##  Post to Twitter
  ###
  def post_to_twitter(message)
    auth = authentications.find_by_provider :twitter
    twitter = Twitter::Client.new(oauth_token: auth.token, oauth_token_secret: auth.secret)
    foo = twitter.update(message)
    #### TODO:  Handle any return messages
    logger.info "~~~~~~~~~~~~~~~~~~  User#post_to_twitter... posted to twitter for: "  + nickname + '  message: ' + message
  end
  
  ###
  ##  Utilities
  ###
  def self.list
    p self.count
    self.find(:all, :order => "current_sign_in_at").each {|u| p u.nickname.ljust(20) + ' ~ ' + u.current_sign_in_at.to_s}
    true
  end
  
end
