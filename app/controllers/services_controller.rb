class ServicesController < Devise::OmniauthCallbacksController
  def authenticate
    ### THIS IS WHERE ALL THE INFOMATION COMES FROM THE PROVIDER.
    omniauth = request.env["omniauth.auth"]
    provider      = omniauth.provider
    uid           = omniauth.uid
    omniauth_info = omniauth.info
    credentials   = omniauth.credentials

    logger.info "~~~~~~~~~~~~~~~~~ ServicesController#create...   " + omniauth.to_yaml      

    service = Service.find_by_provider_and_uid(provider, uid)
    if service
      # flash[:notice] = "Signed in successfully."
      #### TODO: does it pull the rest of the it finish service setup? probably not. Should it?
      sign_in_and_redirect(:user, service.user)
    elsif current_user  ## WHEN ADDING ADDITION AUTHENTIONS. USER IS ALREADY LOGIN
      user = current_user
      user.services.build(provider: provider, uid: uid, token: credentials.token, secret: credentials.secret, info: omniauth.extra.raw_info)
      user.name = omniauth_info.name if user.name.blank?
      user.username = omniauth_info.nickname if user.username.blank?
      user.nickname = omniauth_info.nickname if user.nickname.blank?
      user.location = omniauth_info.location if user.location.blank?
      user.image_url = omniauth_info.image if user.image_url.blank?
      user.description = omniauth_info.description if user.description.blank?
      user.email = omniauth.info.email if user.email.blank?

      if user.save
      flash[:notice] = "Login successful."
        redirect_to root_url
      else
        failure
      end
    else
      ## USER IS NOT LOGGED IN AND HAS NEVER LOGGED IN FROM THIS SERVICE ACCOUNT
      #### TODO: User logs in with twitter, logs out, logs in with facebook. 
      ########## This will create a second user. 
      ########## Perhaps use email address to harmonize them.
      user = User.new
      user.services.build(provider: provider, uid: uid, token: credentials.token, secret: credentials.secret, info: omniauth.extra.raw_info)
      user.name = omniauth_info.name
      user.username = omniauth_info.nickname
      user.nickname = omniauth_info.nickname
      user.location = omniauth_info.location
      user.image_url = omniauth_info.image
      user.description = omniauth_info.description
      user.email = omniauth.info.email
      logger.info "~~~~~~~~~~~~~~~~~ ServicesController#create&  user.save...   " + user.to_yaml      
      logger.info "~~~~~~~~~~~~~~~~~ ServicesController#create&  user.services...   " + user.services.first.to_yaml      

      if user.save
        logger.info "~~~~~~~~~~~~~~~~~ ServicesController#create&  user.save...  GOOD   " 
        flash[:notice] = "Signed up successfully."
        sign_in_and_redirect(:user, user)
      else
        logger.info "~~~~~~~~~~~~~~~~~ ServicesController#create&  user.save...  NOT   "    
        session["devise.user_attributes"] = user.attributes
        #### TODO: where is new_user_registration_url? does it pull the rest of the it finish service setup?
       redirect_to new_user_registration_url
      end
    end
  end

  def destroy
  end

  def failure
  end

  def index
  end

  def twitter
    authenticate
  end

  def facebook
    authenticate
  end
end
