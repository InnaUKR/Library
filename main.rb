# frozen_string_literal: true

require_relative 'library'

library = Library.new
library.add_author('Ашли Ванс',
                   'Ashlee Vance (born 1977) is an American business columnist. His most well known book, Elon Musk: Tesla, SpaceX, and the Quest for a Fantastic Future was released on May 19, 2015.')
library.add_book('Elon Musk', 'Ашли Ванс')

library.load('library_load.json')
library.add_order('Fluent Forever', 'Met')
library.save('library_save.json')

p library.find_most_popular_book
p library.find_greatest_reader
p library.count_readers_of_most_popular_book
