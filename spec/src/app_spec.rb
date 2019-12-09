require_relative '../../src/app'
require_relative '../../src/person'
require_relative '../../src/couple'
require_relative '../../src/single'

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


        person1a = Person.new(name: "Person 1a", phone: "person1a-phone")
        person1b = Person.new(name: "Person 1b", phone: "person1b-phone")
        person2a = Person.new(name: "Person 2a", phone: "person2a-phone")
        person2b = Person.new(name: "Person 2b", phone: "person2b-phone")
        person3a = Person.new(name: "Person 3a", phone: "person3a-phone")
        person3b = Person.new(name: "Person 3b", phone: "person3b-phone")
        person4 = Person.new(name: "Person 4", phone: "person4-phone")

        couples = [
            Couple.new(person1a, person1b),
            Couple.new(person2a, person2b),
            Couple.new(person3a, person3b),
            Single.new(person4)
        ]

        base_url = "http://example.com"


        matches = App.new(couples, base_url).get_matches

        expect(matches.length).to eq 7

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