class RecipeController < ApplicationController

  get '/recipes/new' do
    erb :'/recipes/new'
  end

  post '/recipes' do
    @recipe = Recipe.create(
      name: params[:name], 
      ingredients: params[:ingredients], 
      directions: params[:directions], 
      cook_time: params[:cook_time]
      )
    redirect "/recipes/#{@recipe.id}"
  end

  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :'/recipes/show'
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :'/recipes/index'
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :'/recipes/edit'
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
    if logged_in?
      @recipe = Recipe.find_by_id(params[:id])
      if @recipe.user_id == session[:user_id]
        @recipe.delete
        redirect to '/recipes'
      end
    else
      redirect to '/users/login'
    end
  end

end