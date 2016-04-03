class SponsoredPostController < ApplicationController
  
  def show
    @sponsored_post = SponsoredPost.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @sponsored_post = SponsoredPost.new
  end

  def create
    @sponsored_post = SponsoredPost.new
    @sponsored_post.title = params[:sponsored_post][:title]
    @sponsored_post.body = params[:sponsored_post][:body]
    @sponsored_post.price = params[:sponsored_post][:price]
    @topic = Topic.find(params[:topic_id])
    @post.topic = @topic
    
    @sponsored_post = SponsoredPost.new(sponsored_post_params)
        
    if @sponsored_post.save
      flash[:notice] = "SponsoredPost was saved."
      redirect_to [@topic, @sponsored_post], notice: "Sponsored Post was saved successfully."
    else
        flash.now[:alert] = "Error creating Sponsored Post. Please try again."
        render :new
    end
  end

  def edit
    @sponsored_post = SponsoredPost.find(params[:id])
  end

  def update
    @sponsored_post = SponsoredPost.find(params[:id])

    @sponsored_post.assign_attributes(sponsored_post_params)

    if @sponsored_post.save
      flash[:notice] = "Sponsored Post was updated."
      redirect_to [@sponsored_post.topic, @sponsored_post]
    else
      flash.now[:alert] = "Error saving Sponsored Post. Please try again."
      render :edit
    end
  end

# remember to add private methods to the bottom of the file. Any method defined below private, will be private.
  private
 
  def sponsored_post_params
    params.require(:sponsored_post).permit(:title, :body, :price)
  end
end