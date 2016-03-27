class PostsController < ApplicationController
  def index
    @posts = Post.all
    @posts.each_with_index{ |pst, inx| 0 == inx % 5 ? pst.update(title: "Spam") : pst  }
  end

  def show
  end

  def new
  end

  def edit
  end
end
