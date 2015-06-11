class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @posts = Post.all.where('user_id = ?', params[:id]).order('created_at desc limit 5')
    @user = User.find params[:id]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      redirect_to root_path, notice: 'Success!'
      session[:user_id] = @user.id
    else
      flash.now[:alert] = "Fail"
      render :new
    end
  end

  def follow
    user = User.find params[:id]
    current_user.follow(user)
    redirect_to :back, notice: "You're flattering #{user.name}"
  end

  def unfollow
    user = User.find params[:id]
    current_user.stop_following(user)
    redirect_to :back, notice: "You're not flattering #{user.name} very much"
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
