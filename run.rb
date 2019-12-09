#!/usr/local/bin/ruby
require_relative 'src/app'
require_relative 'src/couple'
require_relative 'src/person'


couples = [
    Couple.new(
        Person.new(name: "max1", email: "max1@email.com"),
        Person.new(name: "max2", email: "max2@email.com"),
    ),
    Couple.new(
        Person.new(name: "ben1", email: "ben1@email.com"),
        Person.new(name: "ben2", email: "ben2@email.com"),
    ),
    Couple.new(
        Person.new(name: "frank1", email: "frank1@email.com"),
        Person.new(name: "frank2", email: "frank2@email.com"),
    ),
]
base_url = "http://example.com/select"
selections = App.new(couples, base_url).get_matches
selections.each do |selection|
  puts(selection)
end