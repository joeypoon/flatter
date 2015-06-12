class UsersController < ApplicationController
  attr_accessor :photo

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
      flash.now[:alert] = "How unflattering"
      render :new
    end
  end

  # def update
  #   current_user.update_column(:photo, user_params[:photo])
  #   binding.pry
  #   if current_user.save
  #     redirect_to current_user, notice: 'Success!'
  #   else
  #     flash.now[:alert] = '💩'
  #     render :show
  #     redirect_to current_user, alert: 'Moo'
  #   end
  # end

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

  def block
    user = User.find_by id: params[:id]
    current_user.block(user)
    redirect_to :back, notice: "You will no longer see any flatter from #{user.name}"
  end

  def unblock
    user = User.find_by id: params[:id]
    current_user.unblock(user)
    redirect_to :back, notice: "You can now get flatter from #{user.name} again!"
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :photo)
    end
end
