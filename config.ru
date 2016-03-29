require 'bundler'
Bundler.require

# Calling SQL database through SEQUEL
DB = Sequel.sqlite('development.sqlite')

# Adding Models
require './models/user'
require './models/review'
require './models/location'

# Adding Controllers
require './controllers/application_controller'
require './controllers/users_controller'
require './controllers/reviews_controller'

# Mapping Routes to Classes
map('/')      { run ApplicationController }
map('/users') { run UsersController }
map('/reviews') { run ReviewsController }
