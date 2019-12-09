class Relationship
  def reset!
    raise NotImplementedError
  end

  def people_count
    raise NotImplementedError
  end

  def selected_giver?(person)
    raise NotImplementedError
  end

  def selected_receiver?(person)
    raise NotImplementedError
  end

  def giver_samples_available?
    raise NotImplementedError
  end

  def receiver_samples_available?
    raise NotImplementedError
  end

  def sample_giver
    raise NotImplementedError
  end

  def sample_receiver
    raise NotImplementedError
  end

  def contains?(person)
    raise NotImplementedError
  end

  def get_partner(person)
    raise NotImplementedError
  end

  def to_s
    raise NotImplementedError
  end
end