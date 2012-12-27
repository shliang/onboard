class ServicesController < Devise::OmniauthCallbacksController




  ## THIS SHOULD NOT HAPPEN AS PEOPLE SIGNED IN WILL NOT BE ABLE TO ADD ANOTHER SERIVCE
  ## WHICH WILL MEAN THAT IF SOMEONE COMES TO THE SITE TWICE AND SIGNS IN WITH DIFFERENT 
  ## SERVICES, THEY WILL BE DIFFERENT ACCOUNTS  
  #### TODO: what if service.user != current_user?  this should mean the accounts should be merged
  #### TODO: does it pull the rest of the it finish service setup? probably not. Should it?
  # elsif  current_user  ## WHEN ADDING ADDITION AUTHENTIONS. USER IS ALREADY LOGIN
    ## THIS SHOULD NOT HAPPEN AS PEOPLE SIGNED IN WILL NOT BE ABLE TO ADD ANOTHER SERIVCE
    ## WHICH WILL MEAN THAT IF SOMEONE COMES TO THE SITE TWICE AND SIGNS IN WITH DIFFERENT 
    ## SERVICES, THEY WILL BE DIFFERENT ACCOUNTS  


  def authenticate
    ### THIS IS WHERE ALL THE INFOMATION COMES FROM THE PROVIDER.
    omniauth = request.env["omniauth.auth"]
    provider = omniauth.provider
    uid      = omniauth.uid
    omniauth_info = omniauth.info
    credentials   = omniauth.credentials

    logger.info "~~~~~~~~~~~~~~~~~ ServicesController#create...   " + omniauth.to_yaml
    logger.info "~~~~~~~~~~~~~~~~~ ServicesController#provider...   " + provider
    logger.info "~~~~~~~~~~~~~~~~~ ServicesController#uid...   " + uid

    service = Service.find_by_provider_and_uid(provider, uid)
    user = !service.nil? ? service.user : nil

    user = User.build_from_omniauth(user, omniauth_info)
    service = Service.build_from_omniauth(user, provider, uid, credentials, omniauth)

    if user.save
      flash[:notice] = "Signed in successfully."
      sign_in_and_redirect(:user, user)
    else
      logger.info "~~~~~~~~~~~~~~~~~ ServicesController#authenticate  FAILURE TO SAVE: "
      flash[:warning] = "There was a problem with signing in.  We are investigating."
      redirect_to root_url
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