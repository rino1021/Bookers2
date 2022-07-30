class UsersController < ApplicationController
before_action :correct_user, only: [:edit,:update]

  def index
    @book = Book.new
    @user = current_user
    @users = User.all
  end
  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books

  end

  def edit
    @user = User.find(params[:id])
    @user == current_user
  end

  def update
    @user = User.find(params[:id])
    if@user.update(user_params)
    redirect_to user_path(@user.id),notice:"You have updated user successfully."
    else
    render:edit
    end
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user =User.new
    if @user.save
      redirect_to user_path(@user)

    end
  end


  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
