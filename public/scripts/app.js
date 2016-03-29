var map = new GMaps({
  zoom: 18,
  div: '#map',
  lat: 41.890551,
  lng: -87.626850
});

$('#geolocate').click(function(){
  map.removeMarkers();
  GMaps.geolocate({
    success: function(position) {
      var lat = position.coords.latitude;
      var lng = position.coords.longitude;

      map.setCenter(lat, lng);

      map.addMarker({
        lat: lat,
        lng: lng,
        label: 'You! (ish)',
        infoWindow: {
          content: '<h4>Your position!</h4>'
        }
      })
      sendLocation(lat,lng);
    },
    error: function(error) {
      console.log('Geolocation failed: '+error.message);
    },
    not_supported: function() {
      console.log("Your browser does not support geolocation");
    },
    always: function() {
      console.log("Done!");
    }
  });

})

$('#address_search').click(function(e){
  map.removeMarkers();
  GMaps.geocode({
    address: $('#address').val().trim(),
    callback: function(results, status) {
      if (status == 'OK') {
        var lat = results[0].geometry.location.lat();
        var lng = results[0].geometry.location.lng();
        map.setCenter(lat, lng);
        map.addMarker({
          infoWindow: {
            content: '<h4>Your position!</h4>'
          },
          label: 'You! (ish)',
          lat: lat,
          lng: lng
        });
        sendLocation(lat, lng);
      } else {
        console.log(status);
      }
    }
  });
})


function sendLocation(lat,lng){
  $.ajax({
    method: 'post',
    url: '/reviews',
    data: {
      "lat": lat,
      "lng": lng
    },
    success: function(data){
      $('#list-results').html('');
      var array_of_places = JSON.parse(data);
      array_of_places.forEach(function(place){
        placeMarker(place);
        if (array_of_places.indexOf(place) < 5) addToList(place);
      })
    },
    failure: function(err){
      console.log(err);
    }
  });
}


function placeMarker(place){
  var self = place;
  self.avgRating = 5;
  self.numReviews = 10;
  map.addMarker({
    lat: self.lat,
    lng: self.lng,
    title: self.place_name,
    infoWindow: {
      content:  '<h4>' + self.place_name + '</h4>' +
                '<p>Average Rating: ' + self.avgRating + '/5</p>' +
                '<small>' + self.numReviews + ' people reviewed this location</small>' +
                '<p><a href="#">Add a review</a></p>'
    }
  })
}

function addToList(place){
  $('#list-results').append('<div class="results-item">' +
                            '<li>' + place.place_name + ' ' + place.avgRating +'/5</li>' +
                            '<li><small><a href="#">Write a review for this location</a></small></li>' +
                            '</div>');
}
