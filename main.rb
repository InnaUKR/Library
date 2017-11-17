# frozen_string_literal: true

require_relative 'library'

library = Library.new
author = Author.new('Ашли Ванс', 'Ashlee Vance (born 1977) is an American business columnist. His most well known book, Elon Musk: Tesla, SpaceX, and the Quest for a Fantastic Future was released on May 19, 2015.')
library.add_author(author)
book = Book.new('Elon Musk', 'Ашли Ванс')
library.add_book(book)

library.load('library_load.json')

order = Order.new('Fluent Forever', 'Met')
library.add_order(order)

library.save('library_save.json')

p library.find_most_popular_book
p library.find_greatest_reader
p library.count_readers_of_most_popular_book
