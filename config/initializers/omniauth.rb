Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV["DEV_TWITTER_APP_ID"], ENV["DEV_TWITTER_APP_SECRET"]
end
