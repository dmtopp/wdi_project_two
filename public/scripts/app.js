var map = new GMaps({
  div: '#map',
  lat: 41.890551,
  lng: -87.626850
});

GMaps.geolocate({
  success: function(position) {
    map.setCenter(position.coords.latitude, position.coords.longitude);

    lat = position.coords.latitude;
    lng = position.coords.longitude;

    $.ajax({
      method: 'get',
      url: 'http://maps.googleapis.com/maps/api/geocode/json?latlng=' + lat +',' + lng,
      success: function(data){
        console.log(data.results[0].formatted_address);
      },
      failure: function(err){
        console.log(err);
      }
    });


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
