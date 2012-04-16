class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
    @title = "Aktuelle Diskussionen"
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    if @post
      @title = "Diskussion #%d" % @post.id
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new
    @title = "Neue Diskussion erstellen"
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])

    unless current_user == @post.user
      redirect_to post_path(@post),
        notice: 'Du kannst nur eigene Diskussionen bearbeiten !!!'
    end

    if @post
      @title = "Diskussion #%d bearbeiten" % @post.id
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])
    @post.user = current_user

    if @post.save
      redirect_to @post, notice: 'Post erfolgreich erstellt.'
    else
      render action: "new"
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    if @post.update_attributes(params[:post])
      redirect_to post_path(@post), notice: 'Post erfolgreich aktualisiert.'
    else
      render action: "edit"
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to posts_url
  end
end
