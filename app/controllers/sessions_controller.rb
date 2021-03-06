class SessionsController < ApplicationController
  skip_filter :authenticate_user!, :only => [:create]

  def new
    @title = "Sign in"
  end

  def create
    auth = request.env['omniauth.auth']
    if @auth = Authorization.find_from_hash(auth)
      @auth.employee.update_from_linkedin(auth)
    else
      # Create a new user or add an auth to existing user, depending on
      # whether there is already a user signed in.
      @auth = Authorization.create_from_hash(auth, current_user)
    end

    if @auth
      # Log the authorizing user in.
      self.current_user = @auth.employee
    else
      flash[:notice] = 'You must work at Razorfish or Globant'
    end

    redirect_to root_path
  end

  def destroy
    # @auth = current_user.
    Rails.logger.debug("session is: #{session.inspect}")
    session[:user_id] = ''
    redirect_to root_url, :notice => "Signed out!"
  end
end

