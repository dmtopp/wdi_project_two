class ApplicationController < Sinatra::Base

  # Load the Secret API Information
  Dotenv.load
  # Set proper directories for public and views
  set :views, File.expand_path('../../views', __FILE__)
  set :public_dir, File.expand_path('../../public', __FILE__)

  enable :sessions
  @message = ''

  def post_review()
      if session[:logged_in] === true
      @get_username = User.where(:user_id=>session[:current_user_id]).get(:username)
      @get_location_id = Location.where(:places_id=>params[:place_id]).get(:location_id)
      if !@get_location_id
        Location.create places_id: params[:place_id]
        @get_location_id = Location.where(:places_id=>params[:place_id]).get(:location_id)
      end
      Review.create  location_id: @get_location_id, rating: params[:stars], who_posted: @get_username
      "Thank you for rating #{@get_username}!"
    else # If user is not logged in store the AJAX call from Frontend in Session to be called later.  Redirect back to erb
      session[:stars] = params[:stars]
      session[:place_id] = params[:place_id]
      erb :login
    end
  # Default Route for ApplicationController
  get '/' do
    erb :main
  end

end
