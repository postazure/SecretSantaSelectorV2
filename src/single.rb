require_relative 'relationship'

class Single < Relationship
  attr_reader :people_count

  def initialize(person)
    @person = person
    reset!
    @people_count = 1
  end

  def reset!
    @person_selected_giver = false
    @person_selected_receiver = false
  end

  def selected_giver?(person)
    if contains? person
      @person_selected_giver
    end
  end

  def selected_receiver?(person)
    if contains? person
      @person_selected_receiver
    end
  end

  def giver_samples_available?
    !@person_selected_giver
  end

  def receiver_samples_available?
    !@person_selected_receiver
  end

  def sample_giver
    raise Exception.new("No more givers to sample") if @person_selected_giver
    @person_selected_giver = true
    @person
  end

  def sample_receiver
    raise Exception.new("No more receivers to sample") if @person_selected_receiver
    @person_selected_receiver = true
    @person
  end

  def contains?(person)
    person == @person
  end

  def get_partner(person)
    nil
  end

  def to_s
    "#{@person.name}:#{@person_selected_giver} #{@person_selected_receiver}"
  end
end