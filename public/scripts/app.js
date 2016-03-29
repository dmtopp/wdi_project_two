var map = new GMaps({
  div: '#map',
  lat: 41.890551,
  lng: -87.626850
});

$('#geolocate').click(function(){

  GMaps.geolocate({
    success: function(position) {
      lat = position.coords.latitude;
      lng = position.coords.longitude;

      map.setCenter(lat, lng);

      map.addMarker({
        lat: lat,
        lng: lng,
        title: 'GA-Chicago',
        infoWindow: {
          content: '<img src="https://media.giphy.com/media/fZk0FD0wxQpb2/giphy.gif">'
        }
      })

      $.ajax({
        method: 'post',
        url: '/reviews',
        data: {
          "lat": lat,
          "lng": lng
        },
        success: function(data){
          console.log(data);
        },
        failure: function(err){
          console.log(err);
        }
      });



      // $.ajax({
      //   method: 'get',
      //   url: 'http://maps.googleapis.com/maps/api/geocode/json?latlng=' + lat +',' + lng,
      //   success: function(data){
      //     console.log(data.results[0].formatted_address);
      //   },
      //   failure: function(err){
      //     console.log(err);
      //   }
      // });


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

  console.log('click addy');

  GMaps.geocode({
    address: $('#address').val().trim(),
    callback: function(results, status) {
      if (status == 'OK') {
        var lat = results[0].geometry.location.lat();
        var lng = results[0].geometry.location.lng();
        map.setCenter(lat, lng);
        map.addMarker({
          lat: lat,
          lng: lng
        });

        $.ajax({
          method: 'post',
          url: '/reviews',
          data: {
            "lat": lat,
            "lng": lng
          },
          success: function(data){
            console.log(data);
          },
          failure: function(err){
            console.log(err);
          }
        });
      } else {
        console.log('wtf')
      }
    }
  });
})
