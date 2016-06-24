class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :upate, :destroy]

  def index
    #zmienna @posts zawiera wszystkie posty ulozone od najnowszego
    @posts = Post.all.order("created_at DESC")
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    #tworze nowy post przypisany do zmiennej @post z post_params
    @post = Post.new(post_params)

    #jesli uda sie zapisac(wszystko bedzie ok) to przechodze do tego postu
    if @post.save
      redirect_to @post
    #jesli nie to renderuje od nowa formularz new
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    #usuwam post i prenosze sie na strone glowna
    @post.destroy
    redirect_to root_path
  end

  private

  def find_post
    #przypisuje do zmiennej @post znaleziony post o konkretnym id
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :link, :description)
  end
end
