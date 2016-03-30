class UsersController < ApplicationController
  get '/' do
    erb :login
  end

  # Registration Page
  # Form Names from Params: username, email, password
  post '/register' do
    password = BCrypt::Password.create(params[:password])
    @new_user = User.create username: params[:username], email: params[:email], password: password
    session[:logged_in] = true
    session[:current_user_id] = @new_user[:user_id]
  end

  get '/whois' do
    @all_users = User.all
    @all_users.to_s
  end

  # Login Page
  # Form Name from Params: username, password
  post '/login' do
    user = User[username: params[:username]]
    stored_password = BCrypt::Password.new(user.password)
    if user && stored_password == params[:password]
      session[:logged_in] = true
      session[:current_user_id] = user[:user_id]
      "Welcome back #{user.username}"
      redirect '../'
    else
      "You have entered the wrong email & password combination"
    end
  end

  # Logout Page
  get '/logout' do
    session.delete[:logged_in]
    session.delete[:current_users_id]
    "You are now logged out"
  end
end
