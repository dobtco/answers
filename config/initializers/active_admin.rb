ActiveAdmin.setup do |config|

  config.site_title = "Civic Answers CMS"

  config.site_title_link = "/admin"

  config.authentication_method = false
  config.current_user_method   = false
  config.logout_link_path       = :destroy_user_session_path
  config.logout_link_method     = :delete

  # config.authorization_adapter = ActiveAdmin::CanCanAdapter

end
