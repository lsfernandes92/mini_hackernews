class StoriesController < ApplicationController
  before_action :set_produto, only: [:destroy]

  def index
    @stories = Story.all
  end

  def show
    @story = Story.find(params[:id])
  end

  def new
    @story = Story.new
    render :new
  end

  def create
    @story = Story.new story_params

    if @story.save
      flash[:notice] = "Story submitted successfully"
      redirect_to root_url
    else
      flash.now[:notice] = "Fail to submit story"
      render :new
    end
  end

  def destroy
    @story.destroy
    redirect_to root_url
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
