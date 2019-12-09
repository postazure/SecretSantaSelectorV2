require 'base64'
require 'json'

class Match
  attr_reader :giver, :receiver, :base_url

  def initialize(giver:, receiver:, base_url:)
    @giver = giver
    @receiver = receiver
    @base_url = base_url
  end


  def to_s
    "#{giver.name}'s url is #{construct_url}"
  end

  def message
    "Hello #{giver.name},\nFollow this link to see your recipient #{construct_url}"
  end

  private

  def construct_url
    "#{base_url}?q=#{Base64.urlsafe_encode64(constuct_json)}"
  end

  def constuct_json
    {
        giver_name: giver.name,
        receiver_name: receiver.name,
    }.to_json
  end
end