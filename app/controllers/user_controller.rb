class UserController < ApplicationController

  get '/users/signup' do
    if logged_in?
      redirect to '/recipes'
    else
      erb :'/users/signup'
    end  
  end

  post '/users/signup' do
    @user = User.create(
      username: params[:username], 
      password: params[:password]
      )
    session[:user_id] = @user.id
    redirect "/users/#{@user.id}"
  end

  get '/users/login' do
    erb :'/users/login'
  end

  post '/users/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:critic_id] = @user.id
      redirect "/recipes"
    else
      redirect "/users/login"
    end
  end

  get '/users/:id' do
    @user = User.find(params[:id])
    erb :'/users/show'
  end

  get '/logout' do
    session.clear
    redirect to '/users/login'
  end


end