require 'sinatra'
require './lib/database_connection'
require './lib/database_connection_setup'
require './lib/user'
require './lib/listings'
require './lib/comment'
require './lib/availability'

class MakersBnb < Sinatra::Base

  enable :sessions , :method_override

  before do 
    check_env
    @user = session[:user_id]
  end

  get '/' do
    erb(:'/listings/index')
  end

  get '/listings/index' do
    erb(:'/listings/index')
  end

  get '/listings' do
    @listings = Listing.all
    erb(:'/listings/index')
  end

  get '/users/new' do
    erb(:'/users/new')
  end

  post '/users/new' do
    @user = User.create(username: params[:username], email: params[:email],
                password: params[:password], name: params[:name])
    session[:user_id] = @user.user_id
    redirect('/listings/index')
  end

  get '/session/new' do
    erb(:'/session/new')
  end

  post '/session/new' do
    # user = User.sign_in(username: params[:username], password: params[:password])
    session[:user_id] = user.user_id
    redirect('/listings/index')
  end

  get '/listing/:id' do
    @listing = Listing.find(params[:id])
    erb(:"/listing/index")
  end

  get '/listing/new' do
    erb(:'/listing/new')
  end

  post '/listing/new' do
    Listing.create(name: params[:name], country: params[:country], city: params[:city],
                   sleeps: params[:sleeps], bedrooms: params[:bedrooms],
                   bathrooms: params[:bathrooms], description: params[:description],
                   type: params[:type], user_id: params[:user_id])
    redirect("/listing/#{listing.listing_id}")
  end

  get '/listing/:id/edit' do
    @listing = Listing.find(params[:id])
    erb(:"/listing/edit")
  end

  patch '/listing/:id' do
    @listing = Listing.edit(listing_id: params[:id], name: params[:name], country: params[:country], 
                            city: params[:city], sleeps: params[:sleep], bedrooms: params[:bedrooms], 
                            bathrooms: params[:bathrooms], description: params[:description], 
                            type: params[:type])
    redirect("/listing/#{@listing.listing_id}")
  end

  run! if app_file == $0
end
