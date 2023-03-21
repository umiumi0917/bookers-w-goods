class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def new
    @book = Book.new
    @user = User.new(user_params)
    if @user.save
      redirect_to  user_path(current_user.id)
    else
      render user_path
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = Book.where(user_id: @user.id)
  end

  def index
      @users =User.all
    	@books = Book.all
    	@book = Book.new
      @user = current_user
  end

  def update
    @user = User.find(params[:id])
     if @user.update(user_params)
      flash[:notice] = "User information was successfully updated "
      redirect_to user_path(current_user.id)
     else
       flash[:notice] = " errors prohibited this obj from being saved:"
       render :edit
     end
  end


  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def is_matching_login_user
    user_id = params[:id].to_i
    unless user_id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end
end
