require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'secret'
    #register Sinatra::Flash => https://medium.com/karuna-sehgal/building-a-sinatra-app-daf7ee3691f4 (Helps implement flash error messages)
  end

  get "/" do
    erb :index
  end

  helpers do

    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

  end

end
