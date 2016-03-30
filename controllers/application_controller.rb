class ApplicationController < Sinatra::Base

  # Load the Secret API Information
  Dotenv.load
  # Set proper directories for public and views
  set :views, File.expand_path('../../views', __FILE__)
  set :public_dir, File.expand_path('../../public', __FILE__)

  enable :sessions
  @message = ''

  # Method that is called in multiple places based on if users is logged in.
  # Allows user to post review from login/registration page if not logged in and trying to post review.
  def post_review(star, place)
    @get_username = User.where(:user_id=>session[:current_user_id]).get(:username)
    @get_location_id = Location.where(:places_id=>place).get(:location_id)
    if !@get_location_id
      Location.create places_id: place
      @get_location_id = Location.where(:places_id=>place).get(:location_id)
    end
    Review.create  location_id: @get_location_id, rating: star, who_posted: @get_username
  end


  # Default Route for ApplicationController
  get '/' do
    erb :main
  end

end
