class ReviewsController < ApplicationController

  # Displays Top 20 Locations via the spot_by_query.  Ideally want to use long and lat for @client.spot(long, lat, options = {})
  post '/' do
    @client = GooglePlaces::Client.new(ENV["API_KEY"])
    location_info = @client.spots(params[:lat], params[:lng], :type=>'establishment', :exclude=>'neighborhood',:rankby=>'distance')
    # erb :display, locals: { location_info: location_info }
    puts params
    @all_locations = []
    location_info.each do |item|
      location = {
        "place_name": item.name,
        "lat": item.lat.to_s,
        "lng": item.lng.to_s,
        "place_id": item.place_id
      }
      @all_locations.push(location)
    end
    @all_locations.to_json
  end


  get '/postreview' do
    if session[:logged_in] === true
      erb :reviewform
    end
  end









end
