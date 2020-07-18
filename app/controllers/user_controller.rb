class UserController < ApplicationController

  get '/users/signup' do
    if logged_in?
      redirect to '/recipes'
    else
      erb :'/users/signup'
    end  
  end

  post '/users/signup' do
    if params[:username].empty? || params[:password].empty?
      flash[:message] = "Be sure to fill out the username and password!"
      redirect to '/users/signup'
    else
      @user = User.create(
        username: params[:username], 
        password: params[:password]
        )
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
    end
  end

  get '/users/' do
    flash[:message] = "That username already exists. Please choose another."
    redirect "/users/signup"
  end

  get '/users/login' do
    erb :'/users/login'
  end

  post '/users/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/recipes"
    else
      flash[:message] = "Login failed. Try again"
      redirect "/users/login"
    end
  end

  get '/users/:id' do
    @user = User.find(params[:id])
    redirect to "/recipes"
  end

  get '/logout' do
    session.clear
    redirect to '/users/login'
  end


end