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
      redirect '../'
    # Normal Registration
    elsif !session[:logged_in] && !session[:stars] && !session[:place_id]
      register_user
      redirect '../'
    else
      pry()
      "Complete and utter failure in the codes"
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
      redirect '../'
    # Normal login
    elsif !session[:logged_in] && !session[:stars] && !session[:place_id]
      login_user
      redirect '../'
    else
      pry()
      "You have failed miserably coders"
    end
  end

  # Logout Get Route
  # Deletes all stored session information
  get '/logout' do
    session.delete(:logged_in)
    session.delete(:current_users_id)
    session.delete(:stars)
    session.delete(:place_id)
    "You are now logged out"
  end
end
