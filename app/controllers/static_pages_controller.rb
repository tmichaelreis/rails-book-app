class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @reading_list_items = current_user.books.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
