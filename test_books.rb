require 'openlibrary'
require 'yaml'

client = Openlibrary::Client.new
view = Openlibrary::View
data = Openlibrary::Data
details = Openlibrary::Details

titles = ['The Great Gatsby', 'The Catcher in the Rye', 'Grapes of Wrath',
          'Of Mice and Men']
          
booksarr = []
titles.each do |title|
  booksarr.push(client.search(title: title)[0])
end

booksarr.each do |book|
  isbn = book.isbn
  puts isbn[0]
  author = book.author_name
  puts author
  cover_i = book.cover_i
  puts cover_i
  
  puts book['key']

end

