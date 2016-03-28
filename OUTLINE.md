# WDI Project 2

#### Objective

Create a yelp-like app for public bathrooms that lets users rate and give reviews.  

#### Minimum goals

+ Users should be able to create accounts
+ Users should be able to modify their account info and delete their account
+ Users should be able to add a new bathroom
+ Users should be able to write a review of a bathroom and give it a rating out of 5 stars
+ **Users should be able to search for bathrooms near their location**

#### Above and beyond

+ Users should be able to add a pictures to bathrooms
+ Users should be able to add tags to locations (i.e. green bathroom, quiet location, etc.)
+ Users should recieve an email confirmation when they create an account

#### Challenges

Using the Google Maps API to search through a list of locations.  This may or may not be possible, our backup plan is to display all locations in a certain neighborhood or zip code as opposed to the ones closest to the user.

#### ERDs
----

Users

|User_id   | Primary Key  |Int |
|---|---|---|
|username   | x  | String  |
|email   | x  | String  |
|password   |   | String  |

----

Locations

| Location_id  | Primary Key   |  Int |
|---|---|---|
|name   |  x | String  |
|how_to_find   |  x | String  |
|place_id   |x   |String   |

----

Reviews

|review_id   | Primary Key   | Int  |
|---|---|---|
|location_id   |FK (locations_id)   |Int   |
|rating   | x  | integer |
|review_text   | x  | Tgitext  |
|who_posted   | x  | String  |

#### Wireframes

Views:
1. Main page w/map and seach
2. Sign up page
3. Login page
4. Modify Acct. info
5. See reviews for a location
6. Write a new review

Main page with map and seach bar:

![main page](summaryimgs/main.png)

Login Page:

![login page](summaryimgs/login.png)

New Account Creation:

![new account](summaryimgs/register.png)

Edit account info:

![edit info](summaryimgs/edit_account.png)


Display All Reviews for a location:

![reviews](summaryimgs/review.png)

Write a new review:

![new review](summaryimgs/write_a_review.png)

Confirm Review:

![confirm](summaryimgs/confirmation_of_review.png)
