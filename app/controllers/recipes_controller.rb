class RecipesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def show
    @recipe = Recipe.find(params[:id])
    @recipe_comment = RecipeComment.new
  end

  def index
    @recipes = Recipe.all
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    if @recipe.save
      redirect_to recipe_path(@recipe), notice: "You have created book successfully."
    else
      @recipes = Recipe.all
      render 'index'
    end
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @recipe.destroy
    redirect_to recipes_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :body)
  end

  def ensure_correct_user
    @recipe = Recipe.find(params[:id])
    unless @recipe.user == current_user
      redirect_to recipes_path
    end
  end
end
