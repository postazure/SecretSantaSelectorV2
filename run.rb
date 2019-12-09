#!/usr/local/bin/ruby

require 'dotenv/load'
require 'twilio-ruby'
require_relative 'src/app'
require_relative 'src/couple'
require_relative 'src/single'
require_relative 'src/person'

# Twilio Creds
account_sid = ENV['TWILIO_SID']
auth_token = ENV['TWILIO_TOKEN']
twilio_number = ENV['TWILIO_NUMBER']
twilio_enabled = !account_sid.nil? && !auth_token.nil? && !twilio_number.nil?
puts "WARN: Twilio is #{'NOT ' unless twilio_enabled}enabled."

# set up a client to talk to the Twilio REST API
twilio = Twilio::REST::Client.new account_sid, auth_token

# Edit the Couples list to your desired configuration
relationships = [
    Couple.new(
        Person.new(name: "max1", phone: "5005550006"),
        Person.new(name: "max2", phone: "5005550006"),
    ),
    Couple.new(
        Person.new(name: "ben1", phone: "5005550006"),
        Person.new(name: "ben2", phone: "5005550006"),
    ),
    Couple.new(
        Person.new(name: "frank1", phone: "5005550006"),
        Person.new(name: "frank2", phone: "5005550006"),
    ),
    Single.new(
        Person.new(name: "alone on xmas", phone: "5005550006")
    )
]

base_url = "http://postazure.com/SecretSantaSelectorV2"
matches = App.new(relationships, base_url).get_matches
matches.each do |match|
  puts(match)

  twilio.messages.create(
      to: '+1' + match.giver.phone,
      from: '+1' + twilio_number,
      body: match.message
  ) if twilio_enabled
end