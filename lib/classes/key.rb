class Key
  attr_reader :user_given_key

  def initialize(user_given_key)
    @user_given_key = user_given_key
  end

  def generate_random_key
    rand(1..99999).to_s.rjust(5, "0")
  end

  def generate_five_digits_with_user_given_key
    @user_given_key.rjust(5, "0")
  end

  def determine_the_key_to_use
    if @user_given_key == ""
      generate_random_key
    else
      generate_five_digits_with_user_given_key
    end
  end
end
