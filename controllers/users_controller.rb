class UsersController < ApplicationController
  get '/' do
    "UsersController has loaded successfully"
  end

  # Registration Page
  # Form Names from Params: username, email, password
  get '/create' do
    password = BCrypt::Password.create('test')
    # @new_user = Users.create username: params[:username], email: params[:email], password: password
    @new_user = User.create username: 'testjosh', email: 'test@joshenglish.com', password: password
    "You have registered {@new_user.username}"
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
    if user && compare_to == params[:password]
      session[:logged_in] = true
      session[:current_user_id] = user[:user_id]
      "Welcome back #{user.username}"
    else
      "You have entered the wrong email & password combination"
    end
  end

  # Logout Page
  get '/logout' do
    session[:logged_in] = false
    "You are now logged out"
  end
end
