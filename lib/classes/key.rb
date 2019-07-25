class Key
  attr_reader :user_given_key, :five_digit_key

  def initialize
    @user_given_key = nil
    @five_digit_key = nil
  end

  def generate_random_key
    rand(1..99999).to_s.rjust(5, "0")
  end

  def generate_five_digits_with_user_given_key
    @user_given_key.rjust(5, "0")
  end

  def make_key(key)
    key.rjust(5, "0")
  end
end
