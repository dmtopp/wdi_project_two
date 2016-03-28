class UsersController < ApplicationController
  get '/' do
    "UsersController has loaded successfully"
  end

  # Registration Page
  # Form Names from Params: username, email, password
  post '/register'
    password = BCrypt::Password.create(params[:password])
    @new_user = Users.create username: params[:username], email: params[:email], password: password
    "You have registered"
  end

  # Login Page
  # Form Name from Params: username, password
  post '/login' do
    user = User[username: params[:username]]

    stored_password = BCrypt::Password.new(user.password)
    if user && compare_to == params[:password]
      session[:logged_in] = true
      session[:current_user_id] = user[:user_id]
      "Welcome back #{user.username}"
    else
      "You have entered the wrong email & password combination"
  end

  # Logout Page
  get '/logout' do
    session[:logged_in] = false
    "You are now logged out"
  end
end
