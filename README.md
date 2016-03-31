# Kastanza

### Overview

Kastanza is a web application for users to find and rate public bathrooms.  It uses the Google Maps API (via Gmaps) and Google places to fetch locations.

### Technologies Used

+ Ruby
+ Sinatra Framework
+ Sequel ORM
+ SQL
+ JavaScript/jQuery
+ HTML/CSS

### The Approach

Users have two options when visiting Kastanza:  Find their location using the geolocation feature of Gmaps, or search for a location by address.  If they search by address, the application makes an ajax call from the front end to Google Maps to convert the address into coordinates.  The coordinates are then sent to the server.

![list of places](/readmeimgs/desktop3.png)
![list of places mobile](/readmeimgs/mobile3.png)

The server then takes those coordinates and uses the Google Places API to return a list of nearby places as well as any ratings associated with those places from the Kastanza database.  The user can then select a location to view its rating or review it.  The review is then stored in the database along with the place id.

### Installation Instructions

This app is live on the internet!  To use it, navigate to [the app](https://kastanza.herokuapps.com/)!

### Unsolved problems

+ Right now the average number of stars is calculated when the server sends the data back to the client.  A better solution would be to cache the values for faster access using Redis or Firebase.

+ There are some unresolved JS issues where selectors are trying to select things on the page that don't exist.  At the moment they don't affect the functionality of the app but they would need to be fixed before expanding the app.

+ User input for creating new users needs to be trimmed and changed to lowercase so Josh and josh act as the same username.

+ Locations can currently be reviewed multiple times by the same user.

### Acknowledgements

+ The fine folks at gmaps.js, Google Maps, and Google Places for providing excellent APIs

+ James, Bill, and Jim for quality instruction and great app name ideas :)

+ James Barnett for sharing his [star rating code on codepen](http://codepen.io/jamesbarnett/pen/vlpkh)

+ YOU for reading this whole document!
