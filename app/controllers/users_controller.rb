class UsersController < ApplicationController
  before_filter :auth_user

  def profiles
    @users = User.all
  end

  def profile
    @user = User.find( params[:id] )
  end

  def destroy_service
    current_user.services.find_by_id(params[:service_id]).destroy
    flash[:success] = 'Successfully disconnected account'
    redirect_to edit_user_registration_path
  end

protected
  def auth_user
    if !user_signed_in?
      redirect_to new_user_session_path, :notice => t(:not_signed_in)
    end
  end
end
