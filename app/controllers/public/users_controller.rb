class Public::UsersController < ApplicationController
  def show
    @user = User.find_by!(name_id: params[:name_id])
  end

  def edit
    @user = User.find_by!(name_id: params[:name_id])
  end

  def update
    @user = User.find_by!(name_id: params[:name_id])
    if @user.update(user_params)
      redirect_to user_path(@user.name_id)
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:name,:name_id,:email,:image)
  end
end
