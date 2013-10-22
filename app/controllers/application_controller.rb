class ApplicationController < ActionController::Base
  include DobtAuth::Controller

  protect_from_forgery

  helper :all

  rescue_from CanCan::AccessDenied do |exception|
    render(:template => 'articles/missing')
  end

end
