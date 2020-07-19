class RecipeController < ApplicationController

  #Create

  get '/recipes/new' do
    if logged_in?
      erb :'/recipes/new'
    else
      flash[:message] = "You need to be logged in to view that page"
      redirect to '/users/login'
    end
  end

  post '/recipes' do
    if params[:name].empty? || params[:ingredients].empty? || params[:directions].empty? || params[:cook_time].empty?
      flash[:message] = "Be sure to fill out all of the form."
      redirect to '/recipes/new'
    else
      @recipe = Recipe.create(
        name: params[:name], 
        ingredients: params[:ingredients], 
        directions: params[:directions], 
        cook_time: params[:cook_time],
        user_id: session[:user_id]
        )
      redirect "/recipes/#{@recipe.id}"
    end
  end

  #Read

  get '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    if @recipe == nil
      erb :oops
    elsif logged_in?
      erb :'/recipes/show'
    else
      flash[:message] = "You need to be logged in to view that page"
      redirect "/users/login"
    end
  end

  get '/recipes' do
    if logged_in?
      @recipes = Recipe.where(user_id: current_user.id).sort_by { |r| r.name }
      erb :'/recipes/index'
    else
      flash[:message] = "You need to be logged in to view that page"
      redirect to '/users/login'
    end
  end

  #Update

  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by(id: params[:id])
    if @recipe == nil
      erb :oops
    elsif logged_in? && @recipe.user_id == current_user.id
      erb :'/recipes/edit'
    else
      flash[:message] = "You need to be logged in to view that page"
      redirect to '/users/login'
    end
  end

  patch '/recipes/:id' do
    if params[:name].empty? || params[:ingredients].empty? || params[:directions].empty? || params[:cook_time].empty?
      flash[:message] = "Can't leave any fields blank. Please try again."
      redirect to "/recipes/#{params[:id]}/edit"
    else
      @recipe = Recipe.find_by_id(params[:id])
      @recipe.update(
        name: params[:name], 
        ingredients: params[:ingredients], 
        directions: params[:directions], 
        cook_time: params[:cook_time]
      )
      flash[:messsage] = "Your recipe has been updated!"
      redirect to "/recipes/#{@recipe.id}"
    end
  end

  #Delete

  delete '/recipes/:id/delete' do
    @recipe = Recipe.find_by_id(params[:id])
    if logged_in? && @recipe.user_id == current_user.id
      @recipe.destroy
      flash[:message] = "Your recipe was successfully deleted!"
      redirect to '/recipes'
    else
      flash[:message] = "You can't delete someone elses recipe! What's wrong with you?!"
      redirect to '/recipes'
    end
  end

end