class ApplicationController < ActionController::Base
  before_filter :authenticate_user!

  protect_from_forgery

  protected

  def current_user
    @current_user ||= Employee.find(session[:user_id])
  end

  def signed_in?
    !!current_user
  end
  
  helper_method :current_user, :signed_in?

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.id
  end

  def authenticate_user!
    Rails.logger.debug("session is: #{session.inspect}")
    if Linkedin.first.nil?
      # redirect to error page
      render :status => 500, :file => File.join(Rails.root, 'public', '500.html')
    else
      redirect_to('/login') unless signed_in?
      # redirect_to('/auth/linked_in') unless signed_in?
    end
    
  end

  def handle_unverified_request
    #TODO save the user_id stored on the session after call super
    #super
  end
end

