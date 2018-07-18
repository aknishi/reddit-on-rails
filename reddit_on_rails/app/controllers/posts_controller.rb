class PostsController < ApplicationController
  
  before_action :require_login

  def create
    @post = Post.new(post_params)
    debugger
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to post_url(@post)
    end
  end

  def show
    @post = Post.find(params[:id])
    @all_comments = @post.comments
    # @post.comments_by_parent_id
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update_attributes(post_params)
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to post_url(@post)
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    redirect_to subs_url
  end
  
  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end
end
