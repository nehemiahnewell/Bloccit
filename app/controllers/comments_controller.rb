class CommentsController < ApplicationController
  before_action :require_sign_in
  before_action :authorize_user, only: [:destroy]
  
  def create
    @commentable, type = load_commentable[0,1]
    comment = @commentable.comments.new(comment_params)
    comment.user = current_user
    if type == "post"
      if comment.save
        flash[:notice] = "Comment saved successfully."
        redirect_to [@commentable.topic, @commentable]
      else
        flash[:alert] = "Comment failed to save."
        redirect_to [@commentable.topic, @commentable]
      end
    elsif type == "topic"
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
    @commentable, type = load_commentable[0,1]
    comment = @commentable.comments.find(params[:id])
    if type == "post"
      if comment.destroy
        flash[:notice] = "Comment was deleted."
        redirect_to [@commentable.topic, @commentable]
      else
        flash[:alert] = "Comment couldn't be deleted. Try again."
        redirect_to [@commentable.topic, @commentable]
      end
    elsif type == "topic"
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
    call_from = request.path.split('/')
    if call_from.length == 3 
      resource, id = call_from[1, 2]
      return @commentable = [resource.singularize.classify.constantize.find(id), "topic"]
    else
      resource, id = call_from('/')[3, 4]
      return @commentable = [resource.singularize.classify.constantize.find(id), "post"]
    end
  end
end