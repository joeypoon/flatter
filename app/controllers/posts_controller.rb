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
    @post = Post.new
    @posts = Post.all.order('created_at desc').page(params[:page])
  end

  private

    def post_params
      params.require(:post).permit(:content)
    end

end
