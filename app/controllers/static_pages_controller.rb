class StaticPagesController < ApplicationController
  before_action :logged_in_user, only: [:feed]

  def intro
    if !logged_in?
      render layout: "intro"
    else
      redirect_to feed_url
    end
  end

  def feed
    @colors = current_user.colors.build
    @feed_colors = current_user.feed.paginate(page: params[:page])
  end

  def about
  end

  def color_analyzer
  end

  def color_picker
  end

  def credits
  end

end
