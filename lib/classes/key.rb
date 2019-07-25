class Key
  attr_reader :user_given_key

  def initialize(user_given_key)
    @user_given_key = user_given_key
  end

  def generate_random_key
    rand(0..99999).to_s.rjust(5, "0")
  end

  def generate_five_digits_with_user_given_key
    @user_given_key.rjust(5, "0")
  end

  def determine_the_key_to_use
    if @user_given_key == ""
      generate_random_key
    else @user_given_key.nil? == false
      generate_five_digits_with_user_given_key
    end
  end

  def assign_letters_to_digits
    key_letter_hash = Hash.new(0)
    key_letter_hash[:A] = determine_the_key_to_use[0..1]
    key_letter_hash[:B] = determine_the_key_to_use[1..2]
    key_letter_hash[:C] = determine_the_key_to_use[2..3]
    key_letter_hash[:D] = determine_the_key_to_use[3..4]
    key_letter_hash
  end
end
