class PagesController < ApplicationController
	before_filter :authenticate_user!, only: [:home]
	def home
	end

	def welcome
	end

	def about
	end

	def contact
	end

	# Terms of service
	def terms
	end

	def privacy
	end

end