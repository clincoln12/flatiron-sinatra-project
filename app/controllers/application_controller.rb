require './config/environment'
require 'sinatra/flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'secret'
    register Sinatra::Flash
  end

  not_found do
    status 404
    erb :oops
  end

  get "/" do
    if !logged_in?
      erb :index
    else
      logged_in_home
    end
  end

  helpers do

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      @user ||= User.find(session[:user_id])
    end

    def logged_in_home
      redirect to '/recipes'
    end

  end

end
