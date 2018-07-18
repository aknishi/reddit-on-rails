class CommentsController < ApplicationController
  
  before_action :require_login

  def create
    @comment = Comment.new(comment_params)
    @comment.parent_comment_id = params[:comment_id] if params[:comment_id]
    
    if @comment.parent_comment_id
      @comment.post_id = @comment.parent_comment.post_id
    else
      @comment.post_id = params[:post_id]
    end

    @comment.user_id = current_user.id
    
    if @comment.save
      if @comment.parent_comment_id
        redirect_to comment_url(@comment.parent_comment_id)
      else
      redirect_to post_url(@comment.post_id)
      end
    else
      flash[:errors] = @comment.errors.full_messages
      if @comment.parent_comment_id
        redirect_to comment_url(@comment.parent_comment_id)
      else
      redirect_to post_url(@comment.post_id)
      end
    end
  end
  
  def show
    @comment = Comment.find(params[:id])
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    if @comment.parent_comment_id
      redirect_to comment_url(@comment.parent_comment_id)
    else
      redirect_to post_url(@comment.post_id)
    end
  end
  
  def comment_params
    params.require(:comment).permit(:content)
  end
end
