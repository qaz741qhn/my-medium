class StoriesController < ApplicationController

  before_action :authenticate_user!, only: [:new, :index, :edit]
  before_action :set_story, :story_not_found, only: [:edit, :update, :destroy]
  skip_before_action :verify_authenticity_token, only: [:clap]

  def index
    @stories = current_user.stories.order(created_at: :desc)
  end

  def new
    @story = current_user.stories.new
  end

  def create
    @story = current_user.stories.new(story_params)
    @story.publish! if params[:publish]

    if @story.save
      if params[:publish]
        flash[:notice] = "已成功發布故事"
        redirect_to stories_path
      else
        flash[:notice] = "故事已儲存"
        redirect_to edit_story_path(@story)
      end
    else
      flash[:alert] = "新增失敗"
      render "new"
    end
  end

  def edit
  end

  def update
    if @story.update(story_params)
      if params[:publish]
        @story.publish!
        flash[:notice] = "故事已發佈"
        redirect_to stories_path
      elsif params[:unpublish]
        @story.unpublish!
        flash[:notice] = "故事已下架"
        redirect_to stories_path
      else
        flash[:notice] = "故事已儲存"
        redirect_to edit_story_path(@story)
      end
    else
      render 'edit'
    end
  end

  def destroy
    @story.destroy
    flash[:alert] = "已刪除故事"
    redirect_to stories_path
  end

  def clap
    if user_signed_in?
      story = Story.friendly.find(params[:id])
      story.increment!(:clap)
      render json: { status: story.clap }
    else
      render json: {status: 'sign_in_first'}
    end
  end

  private

  def story_params
    params.require(:story).permit(:title, :content, :cover_image)
  end

  def set_story
    @story = current_user.stories.friendly.find(params[:id])
  end

  def story_not_found
    if current_user
      if @story.nil?
        render file: Rails.root.join("public/404.html"), layout: false, status: 404
      end
    else
      redirect_to new_user_session_path
    end
  end
end
