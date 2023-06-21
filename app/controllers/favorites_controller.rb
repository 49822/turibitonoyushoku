class FavoritesController < ApplicationController
  def create
    recipe = Recipe.find(params[:recipe_id])
    @favorite = current_user.favorites.new(recipe_id: recipe.id)
    @favorite.save
    render 'replace_btn'
  end

  def destroy
   recipe = Recipe.find(params[:recipe_id])
    @favorite = current_user.favorites.find_by(recipe_id: recipe.id)
    @favorite.destroy
    render 'replace_btn'
  end
end
