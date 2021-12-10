class PagesController < ApplicationController

  before_action :set_story, only: [:show]

  def index
    @stories = Story.published_stories
  end

  def show
  end

  def user
  end

  private

  def set_story
    @story = Story.friendly.find(params[:story_id])
  end

end
