module BooksHelper
  def book_image_for(book, options = { zoom: 1 })
    size = options[:zoom]
    book_response = GoogleBooks.search("isbn:#{book.isbn}").first
    if !book_response.nil?
      book_image_url = book_response.image_link(:zoom => size)
    else
      book_image_url = ""
    end
    image_tag(book_image_url, alt: book.isbn, class: "bookthumb")
  end
end
