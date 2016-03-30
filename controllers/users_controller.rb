class UsersController < ApplicationController

  # Register User Method to be called in our '/register' route.
  def register_user
    password = BCrypt::Password.create(params[:password])
    @new_user = User.create username: params[:username], email: params[:email], password: password
    session[:logged_in] = true
    session[:current_user_id] = @new_user[:user_id]
  end

  # Login user method to be called in our '/login' route
  def login_user
    user = User[username: params[:username]]
    stored_password = BCrypt::Password.new(user.password)
    if user && stored_password == params[:password]
      session[:logged_in] = true
      session[:current_user_id] = user[:user_id]
    else
      "You have entered the wrong username/password"
    end
  end

  # Login/Registration Page
  # default for get for Login Page
  get '/' do
    erb :login
  end

  # Registration Post Route
  # Form Names from Params: username, email, password
  post '/register' do
    # Checks to see if user is coming from '/postreview' route and has stored session info.
    if !session[:logged_in] && session[:stars] && session[:place_id]
      register_user
      post_review(session[:stars], session[:place_id])
      session.delete(:stars)
      session.delete(:place_id)
      @message = "Thanks for creating your account!  Your review has been posted."
      erb :main
    # Normal Registration
    elsif !session[:logged_in] && !session[:stars] && !session[:place_id]
      register_user
      @message = "Thanks for creating your account!"
      erb :main
    else
      @message = "You are already logged in."
      erb :main
    end
  end

  # Login Post Route
  # Form Name from Params: username, password
  post '/login' do
    # Checks to see if user is coming from '/postreview' and has stored session info.
    if !session[:logged_in] && session[:stars] && session[:place_id]
      login_user
      post_review(session[:stars], session[:place_id])
      session.delete(:stars)
      session.delete(:place_id)
      @message = "You are now logged in and your review has been posted."
      erb :main
    # Normal login
    elsif !session[:logged_in] && !session[:stars] && !session[:place_id]
      login_user
      @message = "You are now logged in."
      erb :main
    else
      @message = "You are already logged in."
      erb :main
    end
  end

  # Logout Get Route
  # Deletes all stored session information
  get '/logout' do
    session.delete(:logged_in)
    session.delete(:current_users_id)
    session.delete(:stars)
    session.delete(:place_id)
    @message = "You have been logged out"
    erb :main
  end
end
