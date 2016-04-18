class Api::V1::PostsController < Api::V1::BaseController
  before_action :authenticate_user
  before_action :authorize_user
 
  def show
    post = Post.find(params[:id])
    render json: [post,post.comments], status: 200
  end
 
  def index
    posts = Post.all
    render json: posts, status: 200
  end
end