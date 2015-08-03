class BooksController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def search
    # Search database for existing books
    @search_results = Book.search_db(params[:search]).order("title DESC")
    @search_results_type = "db"
    # If no book can be found, search external API
    if @search_results.length == 0
      client = Openlibrary::Client.new
      @search_results = client.search(params[:search])
      @search_results_type = "api"
    end
  end
end
