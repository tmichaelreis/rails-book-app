class BooksController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  
  def create
    @book = current_user.books.build(book_params)
    if @book.save
      flash[:success] = "Book added!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end
  
  def destroy
  end
  
  def search
    client = Openlibrary::Client.new
    @search_results = client.search(params[:search])
  end
end
