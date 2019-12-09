require 'json'
require 'base64'
require_relative '../../src/match'
require_relative '../../src/Person'

describe Match do
  describe 'to_s' do
    it 'should print out the base64 encoded json for the giver page' do
      giver = Person.new(name: "max", phone: "max-phone")
      receiver = Person.new(name: "rebecca", phone: "rebecca-phone")
      base_url = "https://example.com/selection"

      expected_json = {
          giver_name: giver.name,
          receiver_name: receiver.name,
      }.to_json

      selection = Match.new(giver: giver, receiver: receiver, base_url: base_url)

      expect(selection.to_s).to eq("#{giver.name}'s url is #{base_url}?q=#{Base64.urlsafe_encode64(expected_json)}")
    end

    it 'should have a query value that can be decoded to json' do
      giver = Person.new(name: "max", phone: "max-phone")
      receiver = Person.new(name: "rebecca", phone: "rebecca-phone")
      base_url = "https://example.com/selection"


      selection = Match.new(giver: giver, receiver: receiver, base_url: base_url)
      query = selection.to_s.split("?q=").last
      json = JSON.parse(Base64.decode64(query))

      expect(json).to eq({
                             "giver_name" => giver.name,
                             "receiver_name" => receiver.name,
                         })
    end
  end
end