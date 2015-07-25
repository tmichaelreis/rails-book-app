class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @wish_list_items = current_user.wish_list.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
