class ReviewsController < ApplicationController

  # Displays Top 20 Locations via the spot_by_query.  Ideally want to use long and lat for @client.spot(long, lat, options = {})
  post '/' do
    # @client = GooglePlaces::Client.new(ENV["API_KEY"])
    # location_info = @client.spots_by_query('food near 444 Wabash Ave Chicago IL', :radius=>500)
    # erb :display, locals: { location_info: location_info }
    p params.to_s
  end


end
