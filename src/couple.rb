require_relative 'relationship'

class Couple < Relationship
  attr_reader :people_count

  def initialize(person1, person2)
    @person = person1
    @person2 = person2
    reset!
    @people_count = 2
  end

  def reset!
    @person_selected_giver = false
    @person2_selected_giver = false
    @person_selected_receiver = false
    @person2_selected_receiver = false
  end

  def selected_giver?(person)
    if contains person
      person == @person ? @person_selected_giver : @person2_selected_giver
    end
  end

  def selected_receiver?(person)
    if contains person
      person == @person ? @person_selected_receiver : @person2_selected_receiver
    end
  end

  def giver_samples_available?
    !@person_selected_giver || !@person2_selected_giver
  end

  def receiver_samples_available?
    !@person_selected_receiver || !@person2_selected_receiver
  end

  def sample_giver
    available_people = []
    available_people << @person unless @person_selected_giver
    available_people << @person2 unless @person2_selected_giver

    selected_giver_person = available_people.sample
    raise Exception.new("No more givers to sample") if selected_giver_person == nil

    selected_giver_person == @person ? @person_selected_giver = true : @person2_selected_giver = true

    selected_giver_person
  end

  def sample_receiver
    available_people = []
    available_people << @person unless @person_selected_receiver
    available_people << @person2 unless @person2_selected_receiver

    selected_receiver_person = available_people.sample
    raise Exception.new("No more receivers to sample") if selected_receiver_person == nil

    selected_receiver_person == @person ? @person_selected_receiver = true : @person2_selected_receiver = true

    selected_receiver_person
  end

  def contains?(person)
    person == @person || person == @person2
  end

  def get_partner(person)
    if contains? person
      person == @person ? @person2 : @person
    end
  end

  def to_s
    "#{@person.name}:#{@person_selected_giver} #{@person_selected_receiver}, #{@person2.name}:#{@person2_selected_giver} #{@person_selected_receiver}"
  end
end