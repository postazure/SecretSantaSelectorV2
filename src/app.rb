require_relative './match'

class App
  def initialize(couples, base_url)
    @couples = couples
    @base_url = base_url
  end

  def get_matches
    begin
      return generate_matches(@couples.each(&:reset!))
    rescue ExhaustedCandidatePoolException
      puts "Matching could not be completed, no more candidates available. Redrawing..."
      get_matches
    end
  end

  private

  def generate_matches(couples)
    matches = []
    couples
        .shuffle
        .each do |couple|
      2.times do
        giver = couple.sample_giver

        random_couples = couples
                             .reject { |c| c == couple }
                             .select { |c| c.receiver_samples_available? }

        raise ExhaustedCandidatePoolException if random_couples.empty?

        random_couple = random_couples.sample
        matches << Match.new(giver: giver, receiver: random_couple.sample_receiver, base_url: @base_url)
      end
    end
    matches
  end

  class ExhaustedCandidatePoolException < Exception
  end
end
