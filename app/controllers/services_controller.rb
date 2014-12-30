class ServicesController <  Devise::OmniauthCallbacksController
  def authenticate
    omniauth      = request.env["omniauth.auth"]
    provider      = omniauth.provider
    uid           = omniauth.uid
    omniauth_info = omniauth.info
    credentials   = omniauth.credentials

    service = Service.find_by_provider_and_uid(provider, uid)

    # TODO: What if you sign up with an email, then sign up with a twitter, then log in with email
    # and associate your twitter? (current_user != service.user), and it should assign service.user to current_user
    # and merge the users.
    if !service.nil?
      user = service.user.nil? ? (current_user ? current_user : User.new) : service.user
    else
      user = current_user || User.new
    end
    service = service.nil? ? user.services.new : service
    service.user = user

    user.build_or_update_from_omniauth_info(omniauth_info)
    service.build_or_update_from_omniauth(provider, uid, credentials, omniauth)

    if user.save
      flash[:notice] = "Signed in successfully."
      sign_in_and_redirect(:user, user)
    else
      logger.info "~~~~~~~~~~~~~~~~~ ServicesController#authenticate  FAILURE TO SAVE: #{user.errors.inspect} "
      flash[:warning] = "There was a problem with signing in.  We are investigating."
      redirect_to root_url
    end
  end

  def facebook
    authenticate
  end

  def twitter
    authenticate
  end

  def failure
    auth_info = response.try(:request).try(:env).try(:[], "omniauth.auth")
    if auth_info
      authenticate
    else
      flash[:error] = 'Something went wrong while trying to login'
      redirect_to root_path
    end
  end
end
