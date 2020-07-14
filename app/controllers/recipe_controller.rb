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

end