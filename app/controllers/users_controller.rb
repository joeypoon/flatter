class UsersController < ApplicationController
  attr_accessor :photo

  before_action :set_posts, only: [:show, :update]

  def index
    @users = User.all
  end

  def show
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

  def update
    current_user.photo = user_params[:photo]
    if current_user.save!
      redirect_to user_path(current_user)
    else
      flash.now[:alert] = 'nope'
      render :show
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

    def set_posts
      @posts = Post.all.where('user_id = ?', params[:id]).order('created_at desc limit 5')
    end
    
end
