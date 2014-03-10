class UsersController < ApplicationController

  def profiles
    @users = User.all
  end

end