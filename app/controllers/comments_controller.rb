class CommentsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_story, only: [:create]

  def create
    @comment = @story.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:notice] = "Success"
    else
      flash[:alert] = "Failed"
    end
  end

  private

  def set_story
    @story = Story.friendly.find(params[:story_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

end
