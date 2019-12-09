require_relative '../../src/app'
require_relative '../../src/person'
require_relative '../../src/couple'

describe App do
  def find_partner(couples:, person:)
    couples
        .find { |couple| couple.contains?(person) }
        .get_partner(person)
  end

  describe "get_matches" do
    it 'should generate a list of matches where couples are not matched with each other & no one is matched with themselves' do
      1000.times do
        # Since this is random drawing we should make sure it holds up to multiple attempts.


        person1a = Person.new(name: "Person 1a", email: "person1a@email.com")
        person1b = Person.new(name: "Person 1b", email: "person1b@email.com")
        person2a = Person.new(name: "Person 2a", email: "person2a@email.com")
        person2b = Person.new(name: "Person 2b", email: "person2b@email.com")
        person3a = Person.new(name: "Person 3a", email: "person3a@email.com")
        person3b = Person.new(name: "Person 3b", email: "person3b@email.com")

        couples = [
            Couple.new(person1a, person1b),
            Couple.new(person2a, person2b),
            Couple.new(person3a, person3b),
        ]

        base_url = "http://example.com"


        matches = App.new(couples, base_url).get_matches

        expect(matches.length).to eq 6

        matches.each do |match|
          giver = match.giver
          expect(giver).to be_an_instance_of Person
          expect(giver).not_to eq(find_partner(couples: couples, person: giver))
          expect(giver).not_to eq(match.receiver)
        end
      end
    end
  end
end