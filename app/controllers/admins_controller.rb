class AdminsController < ApplicationController
  before_filter :verify_admin

  def index
    @users = User.all
  end

  private
    def verify_admin
      redirect_to root_path unless current_user.try(:admin?)
    end
end
