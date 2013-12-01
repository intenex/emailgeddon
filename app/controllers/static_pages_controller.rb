class StaticPagesController < ApplicationController
  def home # this controller routes to the static_pages/home --> when someone visits /static_pages/home, Rails will look for the static_pages controller and the home method inside that controller
  end

  def help
  end
end
