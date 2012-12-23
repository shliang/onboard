metric "Email given" do
  description "Someone gave us their email in the account page"
  # User.after_save do |user|
  #   logger.info "~~~~~~~~~~~~~~~~~~  emails_given#after_save...   user " + user.to_yaml
  #   track! if user.email.present?
  # end
end