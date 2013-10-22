class ApplicationController < ActionController::Base
  protect_from_forgery

  helper :all

  rescue_from CanCan::AccessDenied do |exception|
    render(:template => 'articles/missing')
  end

  def current_user
    nil
  end

end
