class StaticPagesController < ApplicationController
  def intro
    render layout: "intro"
  end

  def about
  end
end
