require 'googlebooks'

titles = ['The Great Gatsby', 'Catcher in the Rye', 'Grapes of Wrath',
          'Of Mice and Men']
booksarr = []
titles.each do |title|
  booksarr.push(GoogleBooks.search(title).first)
end

booksarr.each do |book|
  puts book.authors
  puts book.isbn
  puts book.image_link(:zoom => 6)
end

