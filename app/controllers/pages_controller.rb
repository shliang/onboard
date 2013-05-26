class PagesController < ApplicationController
	before_filter :authenticate_user!, only: [:home]
	def home
    @foo = "You are on your home page"
	end

	def welcome
    @foo = "Sign in or sign up"
    @foo = " With SXSW Friends"  if request.subdomain == "sxsw"
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