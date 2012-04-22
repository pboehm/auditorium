class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment])
    @comment.user = current_user
    @comment.save
    set_post_to_viewed(@post)

    redirect_to post_path(@post), :notice => "Kommentar erfolgreich erstellt"
  end
end
