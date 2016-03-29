class ReviewsController < ApplicationController

  # Displays Top 20 Locations via the spot_by_query.  Ideally want to use long and lat for @client.spot(long, lat, options = {})
  post '/' do
    @client = GooglePlaces::Client.new(ENV["API_KEY"])
    #location_info = @client.spot(params[:long],params[:lat], type=>'establishment')
    location_info = @client.spots('41.890651','-87.626968', :type=>'establishment', :exclude=>'neighborhood',:rankby=>'distance')
    erb :display, locals: { location_info: location_info }
  end


  get '/postreview' do
    if session[:logged_in] === true
      erb :reviewform







end
