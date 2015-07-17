class BooksController < ApplicationController
  # Searches openlibrary
  def search
    client = Openlibrary::Client.new
    @search_results = client.search(params[:search])
  end
end
