require 'pry-rescue'
class ServicesController <  Devise::OmniauthCallbacksController

  def authenticate
    binding.pry
    omniauth      = request.env["omniauth.auth"]
    provider      = omniauth.provider
    uid           = omniauth.uid
    omniauth_info = omniauth.info
    credentials   = omniauth.credentials

    service = Service.find_by_provider_and_uid(provider, uid)

    #### TODO: Existing User problem  (if service.user != current_user)
    user = !service.nil? ? service.user : ( current_user ? current_user : User.new )
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
end
