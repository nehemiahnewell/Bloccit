class CommentsController < ApplicationController
  before_action :require_sign_in
  before_action :authorize_user, only: [:destroy]
  
  def create
    load_commentable
    comment = @commentable.comments.new(comment_params)
    comment.user = current_user
    if @resource == "posts"
      if comment.save
        flash[:notice] = "Comment saved successfully."
        redirect_to [@commentable.topic, @commentable]
      else
        flash[:alert] = "Comment failed to save."
        redirect_to [@commentable.topic, @commentable]
      end
    else
      if comment.save
        flash[:notice] = "Comment saved successfully."
        redirect_to [@commentable]
      else
        flash[:alert] = "Comment failed to save."
        redirect_to [@commentable]
      end
    end
  end
  
  def destroy
    load_commentable
    comment = @commentable.comments.find(params[:id])
    if @resource == "posts"
      if comment.destroy
        flash[:notice] = "Comment was deleted."
        redirect_to [@commentable.topic, @commentable]
      else
        flash[:alert] = "Comment couldn't be deleted. Try again."
        redirect_to [@commentable.topic, @commentable]
      end
    else
      if comment.destroy
        flash[:notice] = "Comment was deleted."
        redirect_to [@commentable]
      else
        flash[:alert] = "Comment couldn't be deleted. Try again."
        redirect_to [@commentable]
      end
    end
  end
  private
   
  def comment_params
    params.require(:comment).permit(:body)
  end
   
  def authorize_user
    comment = Comment.find(params[:id])
    unless current_user == comment.user || current_user.admin?
      flash[:alert] = "You do not have permission to delete a comment."
      redirect_to [comment.post.topic, comment.post]
    end
  end
  def load_commentable
    @resource, id = request.path.split('/')[1, 2]
    @commentable = @resource.singularize.classify.constantize.find(id)
  end
end