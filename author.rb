# frozen_string_literal: true

class Author
  attr_reader :name, :biography

  def initialize(name, biography)
    @name = name
    @biography = biography
  end

  #	def to_h
  #			'name'=> @name,
  #			'biography'=> @biography
  #     	}
  # 	end

  def self.json_create(o)
    new(*o['data'])
  end

  def to_json(*a)
    { name: name, biography: biography }.to_json(*a)
  end
end
