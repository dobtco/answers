class HomeController < ApplicationController

  def index
    @popular_categories = Category.by_access_count.limit(3)
  end

  def about
  end

end
