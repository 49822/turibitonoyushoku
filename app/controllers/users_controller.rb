class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]
  before_action :is_matching_login_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes
    @recipe = Recipe.new
  end

  def index
    @users = User.all
    @recipe = Recipe.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "#."
    else
      render "edit"
    end
    @user = User.find(params[:id])
    @user.update(user_params)

  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

   def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to post_images_path
    end
   end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
