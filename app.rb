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
    @availability = Availability.find(listing_id: @listing.listing_id)
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
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])

    array = (start_date..end_date).to_a
    @listing = Listing.find(params[:id])
    array.map { |date| Availability.create(listing_id: @listing.listing_id, dates: date) }
    redirect("/listing/#{@listing.listing_id}")
  end

  delete '/listing/:id' do
    Listing.delete(params[:id])
    redirect('/')
  end

  post '/session/end' do
    session.clear
    redirect('/')
  end

  get '/messages/index' do
    erb(:'messages/index')
  end

  get '/messages/:id/new' do
    session[:recipient_id] = params[:id]
    erb(:'messages/new')
  end

  post '/messages/:id/send' do
    if session[:listing_id] == nil
      session[:listing_id] = "0"
    end
      success = Message.create(listing_id: session[:listing_id], sender_id: @user.user_id, recipient_id: session[:recipient_id], message: params[:message])
    if success
      flash[:message_sent] = 'Message sent!'
    else
      flash[:message_sent] = 'Message sending failed'
    end
    redirect '/'
  end

  run! if app_file == $PROGRAM_NAME
end
