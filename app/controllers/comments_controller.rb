class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new(post_id: @post.id)
    respond_to do |format|
      format.html { render :new, locals: { comment: @comment } }
    end
  end
end
