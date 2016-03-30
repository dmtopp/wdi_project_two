class ReviewsController < ApplicationController

  # Displays Top 20 Locations via the spot_by_query.  Ideally want to use long and lat for @client.spot(long, lat, options = {})
  post '/' do
    @client = GooglePlaces::Client.new(ENV["API_KEY"])
    # Takes lat and long variables from frontend and grabs information from Google Places API Gem returns an array of hashes.
    location_info = @client.spots(params[:lat], params[:lng], :type=>'establishment', :exclude=>'neighborhood',:rankby=>'distance')
    # Creating an array of hashes for json to send back to frontend Javascript.
    @all_locations = []
    location_info.each do |item|
      # SQL statement getting Average Rating based on the Place_ID from Google Places
      @sum_rating = Review.where(:location_id=>(Location.where(:places_id=>item.place_id).get(:location_id))).get{sum(rating)}
      # SQL statement getting the count by inner joining reviews table with locations table.
      @the_count =  DB["select count(*) as 'count_rating' from reviews r inner join locations l ON r.location_id = l.location_id where l.places_id = '#{item.place_id}'"].all || 0
      # Calculating average rating of location on the fly.  **FUTURE STATE** Would like to use some caching options but time was limted by project deadline (Redis or Firebase)
      if @the_count[0][:count_rating] > 0
        @average_rating = (@sum_rating.to_f / @the_count[0][:count_rating])
      else
        @average_rating = -1
      end
      location = {
        "place_name": item.name,
        "lat":        item.lat.to_s,
        "lng":        item.lng.to_s,
        "place_id":   item.place_id,
        "avg_rating": @average_rating.round(2),
        "the_count":  @the_count[0][:count_rating]
      }
      @all_locations.push(location)
    end
    @all_locations.to_json
  end


  post '/postreview' do
    if session[:logged_in] === true
      post_review(params[:stars], params[:place_id])
      @message = "Thank you for posting your review!"
      erb :main
    else # If user is not logged in store the AJAX call from Frontend in Session to be called later.  Redirect back to erb
      session[:stars] = params[:stars]
      session[:place_id] = params[:place_id]
      @message = "Please login or register before posting your review."
      erb :login
    end

  end

end
