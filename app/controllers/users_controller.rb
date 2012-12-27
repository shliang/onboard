class UsersController < ApplicationController

  def show
    @user = current_user
    if @user.blank?
      redirect_to root_path, notice: "You must be signed in!"
    end
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
  
end