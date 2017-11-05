# frozen_string_literal: true

class Reader
  attr_reader :name, :email, :city, :street, :house

  def initialize(name, email, city, street, house)
    @name = name
    @email = email
    @city = city
    @street = street
    @house = house
  end

  def to_json(*a)
    { name: name,
      email: email,
      city: city,
      street: street,
      house: house }.to_json(*a)
  end
end
