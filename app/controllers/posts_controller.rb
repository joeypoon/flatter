class PostsController < ApplicationController

  def create
    @post = Post.new post_params
    @post.user = current_user
    if @post.save
      redirect_to root_path, notice: 'Success!'
    else
      flash.now[:alert] = "Fail"
      render :index
    end
  end

  def index
    all_user_ids = User.all.map { |user| user.id }
    all_user_ids.delete(current_user.id)
    not_following_list = all_user_ids.reject { |user_id| current_user.following? User.find_by(id:user_id) }
    @users = User.all.where(id: not_following_list)[0..9]

    @post = Post.new
    if current_user
      follower_ids = current_user.all_following.map { |user| user.id }
      all_ids = follower_ids << current_user.id
      @posts = Post.all.where(user_id: all_ids).order('created_at desc').page(params[:page])
    else
      @posts = Post.all.order('created_at desc').page(params[:page])
    end
  end

  private

    def post_params
      params.require(:post).permit(:content)
    end

end
