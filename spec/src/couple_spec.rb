require_relative '../../src/couple'
require_relative '../../src/person'

describe Couple do
  describe "contains" do
    it 'should return true if the person is a member of the couple' do
      person = Person.new(name: "person", email: "person-email")
      partner = Person.new(name: "partner", email: "partner-email")
      not_partner = Person.new(name: "not-partner", email: "not-partner-email")

      expect(Couple.new(person, partner).contains?(partner)).to be true
      expect(Couple.new(person, partner).contains?(not_partner)).to be false
    end
  end

  describe "get_partner" do
    it 'should the partner of the person if the person is a member of the couple' do
      person = Person.new(name: "person", email: "person-email")
      partner = Person.new(name: "partner", email: "partner-email")
      not_partner = Person.new(name: "not-partner", email: "not-partner-email")

      expect(Couple.new(person, partner).get_partner(partner)).to be person
      expect(Couple.new(person, partner).get_partner(person)).to be partner
      expect(Couple.new(person, partner).get_partner(not_partner)).to be nil
    end
  end
end