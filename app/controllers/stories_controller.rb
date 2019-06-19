class StoriesController < ApplicationController
  before_action :set_produto, only: [:show, :destroy]

  def index
    @stories = Story.all
  end

  def show
  end

  def new
    @story = Story.new
    render :new
  end

  def create
    @story = Story.new story_params

    if @story.save
      flash[:notice] = "Story submitted successfully!"
      redirect_to root_url
    else
      render :new
    end
  end

  def destroy
    if @story.destroy
      flash[:notice] = "Story deleted successfully!"
      redirect_to root_url
    else
      flash.now[:notice] = "Fail to delete story."
      render :new
    end
  end

    private

    def story_params
      params.require(:story).permit(:title, :url)
    end

    def set_produto
      id = params[:id]
      @story = Story.find(id)
    end
end
