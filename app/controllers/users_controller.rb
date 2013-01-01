class UsersController < ApplicationController

  def profiles
    @users = User.all
  end

  def profile
    @user = User.find(params[:id])
    
    @fb = setup_for_facebook(@user)
    # logger.info "~~~~~~~~~~~~~~~~~ UsersControllerprofile  fb: " + @fb.to_yaml
  end

  def account
    @user = current_user
    if @user.blank?
      redirect_to root_path, notice: "You must be signed in!"
    end
    
    @fb = setup_for_facebook(@user)
  end

  def update
    @user = User.find(params[:id])
    email_present = @user.email.present?

    respond_to do |format|
      if @user.update_attributes(params[:user])
        if !email_present && @user.email.present?
          track! :email_given
        end
        format.html { redirect_to user_show_path, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
  
  def setup_for_facebook(user)
    fb = nil
    if fb_service = user.services.find_by_provider(:facebook)
      fb = Fb.new
      fb.setup(@user)
      logger.info "~~~~~~~~~~~~~~~~~ UsersController  fb: " + fb.to_yaml
      # logger.info "~~~~~~~~~~~~~~~~~ UsersController  profile: " + @fb.profile.to_yaml
      # logger.info "~~~~~~~~~~~~~~~~~ fbUsersController  friends: " + @fb.friends.to_yaml
      # logger.info "~~~~~~~~~~~~~~~~~ fbUsersController  feed: " + @fb.feed.to_yaml
    end
    fb
  end
  
end