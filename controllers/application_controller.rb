class ApplicationController < Sinatra::Base

  # Set proper directories for public and views
  set :views, File.expand_path('../../views', __FILE__)
  set :public_dir, File.expand_path('../../public', __FILE__)

  enable :sessions

  # Default Route for ApplicationController
  get '/' do
    erb :index
  end

end
