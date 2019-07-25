class Key
  # attr_reader :user_given_key
  #
  # def initialize(user_given_key)
  #   @user_given_key = user_given_key
  # end

  def generate_random_key
    rand(0..99999).to_s.rjust(5, "0")
  end

  def generate_five_digits_with_user_given_key
    @user_given_key.rjust(5, "0")
  end



end
