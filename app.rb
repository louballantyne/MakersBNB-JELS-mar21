require 'sinatra'
require 'sinatra/flash'
require './lib/database_connection'
require './lib/database_connection_setup'
require './lib/user'
require './lib/listing'
require './lib/message'
require './lib/availability'

class MakersBnb < Sinatra::Base

  enable :sessions , :method_override
  register Sinatra::Flash

  before do
    check_env
    @listings = Listing.all
    @user = session[:user]
  end

  get '/' do
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
    user = User.create(username: params[:username], email: params[:email],
                password: params[:password], name: params[:name])
    if user == 1
      flash[:username_exists_warning] = "Username in use"
    elsif user == 2
      flash[:email_warning] = "Email address already registered"
    else
      session[:user] = user
      redirect('/')
    end
    redirect('/users/new')
  end

  get '/session/new' do
    erb(:'/session/new')
  end

  post '/session/new' do
    user = User.sign_in(username: params[:username], password: params[:password])
    if user == 1
      flash[:username_warning] = "Please check your username"
    elsif user == 2
      flash[:password_warning] = "Please check your password"
    else
      session[:user] = user
      redirect('/')
    end
    redirect('/session/new')
  end

  get '/listing/new' do
    erb(:'/listing/new')
  end

  get '/listing/:id' do
    @listing = Listing.find(params[:id])
    erb(:"/listing/index")
  end

  post '/listing' do
    listing = Listing.create(name: params[:name], country: params[:country], city: params[:city],
                   sleeps: params[:sleeps], bedrooms: params[:bedrooms],
                   bathrooms: params[:bathrooms], description: params[:description],
                   type: params[:type], user_id: @user.user_id)
    redirect("/listing/#{listing.listing_id}")
  end

  get '/listing/:id/edit' do
    @listing = Listing.find(params[:id])
    erb(:"/listing/edit")
  end

  patch '/listing/:id' do
    p params
    @listing = Listing.edit(listing_id: params[:id], name: params[:name], country: params[:country],
                            city: params[:city], sleeps: params[:sleeps], bedrooms: params[:bedrooms],
                            bathrooms: params[:bathrooms], description: params[:description],
                            type: params[:type])
    redirect("/listing/#{@listing.listing_id}")
  end

  delete '/listing/:id' do
    # Listing.delete(params[:id])
    redirect('/')
  end

  post '/session/end' do
    session.clear
    redirect('/')
  end

  run! if app_file == $0
end
