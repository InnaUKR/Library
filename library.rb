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

  def add_author(author)
    raise ArgumentError, "Author with name - #{author.name} already exists" if @authors[author.name]
    @authors[author.name] = author
  end

  def add_book(book)
    raise ArgumentError, "Author with name - #{book.author} does not exist" unless @authors[book.author]
    @books[book.title] = book
  end

  def add_reader(reader)
    raise ArgumentError, "Reader with name #{reader.name} already exists" if @readers[reader.name]
    @readers[reader.name] = reader
  end

  def add_order(order)
    raise ArgumentError, "Reader with name - #{order.reader} does not exist" unless @readers[order.reader]
    raise ArgumentError, "Book with title - #{order.book} does not exist" unless @books[order.book]
    @orders << order
  end

  def find_most_popular_book
    hash_book_amount = get_hash_of_counted_book
    find_greatest(hash_book_amount)
  end

  def find_greatest_reader
    hash_reader_amount = @orders.each_with_object(Hash.new(0)) do |order, counts|
      counts[order.reader] += 1
    end
    find_greatest(hash_reader_amount)
  end

  def count_readers_of_most_popular_book
    hash_book_number = get_hash_of_counted_book
    sorted_array = hash_book_number.sort_by(&:last).reverse
    sorted_array[0..2].inject(0) { |sum, arr_book_amount| sum + arr_book_amount[1] }
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

  private

  def get_hash_of_counted_book
    @orders.each_with_object(Hash.new(0)) do |order, counts|
      counts[order.book] += 1
    end
  end

  def find_greatest(hash_something_amount)
    sorted_array = hash_something_amount.sort_by(&:last).reverse
    greatest = []
    sorted_array.take_while { |x| sorted_array[0][1] == x[1] }.each do |x|
      greatest << x[0]
    end
    greatest
  end

  def to_json
    {
      'authors' => @authors,
      'books' => @books,
      'readers' => @readers,
      'orders' => @orders
    }
  end

  def authors_from_json(data_hash)
    data_hash['authors']&.each_value do |author|
      add_author(Author.new(author['name'], author['biography']))
    end
  end

  def books_from_json(data_hash)
    data_hash['books']&.each_value do |book|
      add_book(Book.new(book['title'], book['author']))
    end
  end

  def readers_from_json(data_hash)
    data_hash['readers']&.each_value do |reader|
      add_reader(Reader.new(reader['name'],
                            reader['email'],
                            reader['city'],
                            reader['street'],
                            reader['house']))
    end
  end

  def orders_from_json(data_hash)
    data_hash['orders']&.each do |reader|
      add_order(Order.new(reader['book'], reader['reader'], reader['date']))
    end
  end

  def from_json(file)
    data_hash = JSON.parse(file)
    authors_from_json(data_hash)
    books_from_json(data_hash)
    readers_from_json(data_hash)
    orders_from_json(data_hash)
  end
end
