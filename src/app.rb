require_relative './match'

class App
  def initialize(relationships, base_url)
    @relationships = relationships
    @base_url = base_url
  end

  def get_matches
    begin
      return generate_matches(@relationships.each(&:reset!))
    rescue ExhaustedCandidatePoolException
      puts "Matching could not be completed, no more candidates available. Redrawing..."
      get_matches
    end
  end

  private

  def generate_matches(relationships)
    matches = []
    relationships
        .shuffle
        .each do |couple|
      couple.people_count.times do
        giver = couple.sample_giver

        random_couples = relationships
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
