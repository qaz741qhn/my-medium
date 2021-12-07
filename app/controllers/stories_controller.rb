class StoriesController < ApplicationController

  before_action :authenticate_user!, only: [:new, :index]
  before_action :set_story, only: [:show, :edit, :update, :destroy]

  def index
    @stories = current_user.stories.order(created_at: :desc)
  end

  def new
    @story = current_user.stories.new
  end

  def create
    @story = current_user.stories.new(story_params)
    if @story.save
      flash[:notice] = "新增成功"
      redirect_to stories_path
    else
      flash[:alert] = "新增失敗"
      render "new"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @story.update(story_params)
      redirect_to story_path(@story)
    else
      render "edit"
    end
  end

  def destroy
    @story.destroy
    redirect_to stories_path
  end

  private

  def story_params
    params.require(:story).permit(:title, :content)
  end

  def set_story
    @story = current_user.stories.find_by(id: params[:id])
  end
end
