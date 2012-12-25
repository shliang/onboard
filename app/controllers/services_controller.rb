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
      ## THIS SHOULD NOT HAPPEN AS PEOPLE SIGNED IN WILL NOT BE ABLE TO ADD ANOTHER SERIVCE
      ## WHICH WILL MEAN THAT IF SOMEONE COMES TO THE SITE TWICE AND SIGNS IN WITH DIFFERENT 
      ## SERVICES, THEY WILL BE DIFFERENT ACCOUNTS  
      #### TODO: what if service.user != current_user?  this should mean the accounts should be merged
      #### TODO: does it pull the rest of the it finish service setup? probably not. Should it?
      sign_in_and_redirect(:user, service.user)

    # elsif  current_user  ## WHEN ADDING ADDITION AUTHENTIONS. USER IS ALREADY LOGIN
      ## THIS SHOULD NOT HAPPEN AS PEOPLE SIGNED IN WILL NOT BE ABLE TO ADD ANOTHER SERIVCE
      ## WHICH WILL MEAN THAT IF SOMEONE COMES TO THE SITE TWICE AND SIGNS IN WITH DIFFERENT 
      ## SERVICES, THEY WILL BE DIFFERENT ACCOUNTS  
    else
      user = User.from_omniauth(omniauth_info)
      user.services.build(provider: provider, uid: uid, token: credentials.token, secret: credentials.secret, info: omniauth.extra)
      logger.info "~~~~~~~~~~~~~~~~~ ServicesController#authenticate  user: " + user.to_yaml      
      logger.info "~~~~~~~~~~~~~~~~~ ServicesController#authenticate  user.services: " + user.services.find_by_provider(provider).to_yaml      
      if user.save
        flash[:notice] = "Signed in successfully."
        sign_in_and_redirect(:user, user)
      else
        failure
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
