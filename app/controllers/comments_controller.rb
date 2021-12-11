class CommentsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_story, only: [:create]

  def create
    @comment = @story.comments.new(comment_params)
    @comment.user = current_user

    unless @comment.save
      render js: "alert('請輸入留言')"
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
