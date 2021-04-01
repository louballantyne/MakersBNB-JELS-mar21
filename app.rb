# frozen_string_literal: true

require 'sinatra'
require 'sinatra/flash'
require './lib/database_connection'
require './lib/database_connection_setup'
require './lib/user'
require './lib/listing'
require './lib/message'
require './lib/availability'
require 'date'

class MakersBnb < Sinatra::Base
  enable :sessions, :method_override
  register Sinatra::Flash

  before do
    check_env
    @listings = Listing.all
    @user = session[:user]
  end

  get '/' do
    redirect '/listings'
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
                       password: params[:password], confirm: params[:confirm], 
                       first_name: params[:first_name], last_name: params[:last_name])
    case user
    when 1
      flash[:username_exists_warning] = 'Username in use'
    when 2
      flash[:email_warning] = 'Email address already registered'
    when 3
      flash[:password_match] = 'The passwords entered do not match'
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
    case user
    when 1
      flash[:username_warning] = 'Please check your username'
    when 2
      flash[:password_warning] = 'Please check your password'
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
                             type: params[:type], price: params[:price], user_id: @user.user_id)
    redirect("/listing/#{listing.listing_id}")
  end

  get '/listing/:id/edit' do
    @listing = Listing.find(params[:id])
    erb(:"/listing/edit")
  end

  patch '/listing/:id' do
    @listing = Listing.edit(listing_id: params[:id], name: params[:name], country: params[:country],
                            city: params[:city], sleeps: params[:sleeps], bedrooms: params[:bedrooms],
                            bathrooms: params[:bathrooms], description: params[:description],
                            type: params[:type], price: params[:price])
    redirect("/listing/#{@listing.listing_id}")
  end

  get '/listing/:id/availability' do
    @listing = Listing.find(params[:id])
    erb(:"/listing/availability")
  end

  post '/listing/:id/availability' do
   
    a = Date.parse params[:start_date]
    b = Date.parse params[:end_date]
    @date_test = (a..b).inject([]){|accum, date| accum << date}

    p @date_test 
    # @date_test = (Date.parse(params[:start_date]))…Date.parse(params[:end_date])).to_a
    
    #p @date_test
    #Date.new(params[:start_date], params[:end_date])
    #DateRange((params[:start_date]...params[:end_date])).every(1.day)
  end

  delete '/listing/:id' do
    Listing.delete(params[:id])
    redirect('/')
  end

  post '/session/end' do
    session.clear
    redirect('/')
  end

  run! if app_file == $PROGRAM_NAME
end
