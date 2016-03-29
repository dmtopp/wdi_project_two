class ReviewsController < ApplicationController

  # Displays Top 20 Locations via the spot_by_query.  Ideally want to use long and lat for @client.spot(long, lat, options = {})
  post '/' do
    @client = GooglePlaces::Client.new(ENV["API_KEY"])
    location_info = @client.spots(params[:lat], params[:lng], :type=>'establishment', :exclude=>'neighborhood',:rankby=>'distance')
    # erb :display, locals: { location_info: location_info }
    @all_locations = []
    location_info.each do |item|
      @average_rating = Location.where(:places_id=>item.place_id).get(:avg_rating) || -1
      @the_count =  DB["select count(*) as 'count_rating' from reviews r inner join locations l ON r.location_id = l.location_id where l.places_id = '#{item.place_id}'"].all || 0
      location = {
        "place_name": item.name,
        "lat":        item.lat.to_s,
        "lng":        item.lng.to_s,
        "place_id":   item.place_id,
        "avg_rating": @average_rating,
        "the_count":  @the_count[0][:count_rating]
      }
      @all_locations.push(location)
    end
    @all_locations.to_json
  end

  get '/postreview' do
    if session[:logged_in] === true

    end
  end









end
