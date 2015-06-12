class PostsController < ApplicationController

  before_action do
    @post = Post.new

    if current_user
      all_user_ids = User.all.map { |user| user.id }
      all_user_ids.delete(current_user.id)
      not_following_list = all_user_ids.reject { |user_id| current_user.following? User.find_by(id:user_id) }
      @users = User.all.where(id: not_following_list)[0..9]
    end
  end

  def create
    if authenticate_user
      @post = Post.new post_params
      @post.user = current_user
      if @post.save
        redirect_to root_path, notice: 'Success!'
      else
        redirect_to :back, alert: 'Fail'
      end
    end
  end

  def index
    if current_user
      follower_ids = current_user.all_following.map { |user| user.id }
      blocked_ids = current_user.blocks.map { |blocked_user| blocked_user.id }
      all_ids = follower_ids << current_user.id
      all_ids = all_ids.reject { |id| blocked_ids.include? id }
      @posts = Post.all.where(user_id: all_ids).order('created_at desc').page(params[:page])
    else
      @posts = Post.all.order('created_at desc').page(params[:page])
    end
  end

  def search
    @posts = Post.search(params[:search][:search_word]).order('created_at desc').page(params[:page])
    render :index
  end

  private

    def post_params
      params.require(:post).permit(:content, :photo)
    end

end
