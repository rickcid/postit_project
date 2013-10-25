class UsersController < ApplicationController
before_action :set_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "You are registered!"
      redirect_to root_path
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @user.update(user_params)
      flash[:notice] = 'Your profile is updated.'
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end 

  def set_user
    @user = User.find_by(slug: params[:id])
  end
end
