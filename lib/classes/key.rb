class Key
  attr_reader :five_digit_key

  def initialize
    @five_digit_key = nil
  end

  def generate_random_key
    rand(1..99999).to_s.rjust(5, "0")
  end

  def make_key(key)
    @five_digit_key = key.rjust(5, "0")
  end
end
