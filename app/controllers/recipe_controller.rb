class RecipeController < ApplicationController

  get '/recipes/new' do
    if logged_in?
      erb :'/recipes/new'
    else
      flash[:message] = "You need to be logged in to view that page"
      redirect to '/users/login'
    end
  end

  post '/recipes' do
    @recipe = Recipe.create(
      name: params[:name], 
      ingredients: params[:ingredients], 
      directions: params[:directions], 
      cook_time: params[:cook_time],
      user_id: session[:user_id]
      )
    redirect "/recipes/#{@recipe.id}"
  end

  get '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    if @recipe == nil
      erb :oops
    else
      erb :'/recipes/show'
    end
  end

  get '/recipes' do
    if logged_in?
      #@recipes = Recipe.all.sort_by { |r| r.name }
      @recipes = Recipe.where(user_id: current_user.id).sort_by { |r| r.name }
      erb :'/recipes/index'
    else
      #flash[:message] = "You need to be logged in to view that page"
      redirect to '/users/login'
    end
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by(params[:id])
    if @recipe == nil
      erb :oops
    else
      erb :'/recipes/edit'
    end
  end

  post '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    @recipe.update(
      name: params[:name], 
      ingredients: params[:ingredients], 
      directions: params[:directions], 
      cook_time: params[:cook_time]
    )
    redirect "/recipes/#{@recipe.id}"
  end

  #Delete

  delete '/recipes/:id/delete' do
    @recipe = Recipe.find_by_id(params[:id])
    if logged_in? && @recipe.user_id == current_user.id
      @recipe.destroy
      redirect to '/recipes'
    else
      flash[:message] = "You can't delete someone elses recipe! What's wrong with you?!" #not working yet - must fix
      redirect to '/recipes'
    end
  end

end