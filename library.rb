# frozen_string_literal: true

require 'json'
require_relative 'author'
require_relative 'book'
require_relative 'reader'
require_relative 'order'

class Library
  attr_accessor :books, :orders, :readers, :authors

  def initialize(books = {}, orders = [], readers = {}, authors = {})
    @books = books
    @orders = orders
    @readers = readers
    @authors = authors
  end

  def add_author(name, biography)
    raise ArgumentError if @authors[name]
    # doesn't copy the author's names
    @authors[name] = Author.new(name, biography)
  rescue ArgumentError
    puts "Author '#{name}' already exist"
  end

  def add_book(title, author_name)
    raise ArgumentError unless @authors[author_name]
    @books[title] = Book.new(title, author_name)
  rescue ArgumentError
    puts "Author #{author_name} doesn't exist"
  end

  def add_reader(name, email, city, street, house)
    raise ArgumentError if @readers[name]
    @readers[name] = Reader.new(name, email, city, street, house)
  rescue ArgumentError
    puts "Reader '#{name}' already exist"
  end

  def add_order(book_name, reader_name, date = Time.now)
    raise ArgumentError if !@readers[reader_name] && !@books[book_name]
    @orders << Order.new(book_name, reader_name, date)
  rescue ArgumentError
    puts "Something wrong with reader: '#{reader_name}'
          or with book:'#{book_name}'"
  end

  def inverse(hash)
    i = {}
    hash.each_pair do |k, v|
      if v.class == Array
        v.each do |x|
          i[x] = i.key?(x) ? [k, i[x]].flatten : k
        end
      else
        i[v] = i.key?(v) ? [k, i[v]].flatten : k
      end
    end
    i
  end

  def hesh_of_counted_book
    @orders.each_with_object(Hash.new(0)) do |order, counts|
      counts[order.book] += 1
    end
  end

  def find_most_popular_book
    result = hesh_of_counted_book
    inverse(result)[result.values.max]
  end

  def find_greatest_reader
    result = @orders.each_with_object(Hash.new(0)) do |order, counts|
      counts[order.reader] += 1
    end
    inverse(result)[result.values.max]
  end

  def count_readers_of_most_popular_book
    result = hesh_of_counted_book
    sorted_array_result = result.sort { |a1, a2| a2[1] <=> a1[1] }
    sorted_array_result[0..2].inject(0) { |sum, x| sum + x[1] }
  end

  def save(file)
    File.open(file, 'w') do |f|
      f.write(JSON.pretty_generate(to_json))
    end
  end

  def load(filename)
    file = File.read(filename)
    from_json(file)
  rescue Errno::ENOENT
    puts 'File not found'
  end

  def to_json
    {
      'authors' => @authors,
      'books' => @books,
      'readers' => @readers,
      'orders' => @orders
    }
  end

  def from_json(file)
    data_hash = JSON.parse(file)
    data_hash['authors']&.each_value do |author|
      add_author(author['name'], author['biography'])
    end
    data_hash['books']&.each_value do |book|
      add_book(book['title'], book['author'])
    end
    data_hash['readers']&.each_value do |reader|
      add_reader(reader['name'],
                 reader['email'],
                 reader['city'],
                 reader['street'],
                 reader['house'])
    end
    data_hash['orders']&.each do |reader|
      add_order(reader['book'], reader['reader'], reader['date'])
    end
  end
end
