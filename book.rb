# frozen_string_literal: true

class Book
  attr_reader :title, :author

  def initialize(title, author)
    @title = title
    @author = author
  end

  def to_json(*a)
    { title: title, author: author }.to_json(*a)
  end

  def to_s
    "title: #{title}, author: #{author}"
  end
end
