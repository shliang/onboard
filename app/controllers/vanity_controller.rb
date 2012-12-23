class VanityController < ApplicationController
	before_filter :check_admin
	include Vanity::Rails::Dashboard
	include Vanity::Rails::TrackingImage

	def check_admin
		redirect_to root_path unless current_user.admin?
	end

end