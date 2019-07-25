class Shift
  attr_reader :key, :offset

  def initialize(key, offset)
    @key = key
    @offset = offset
  end

  def assign_letters_to_key_digits
    key_letter_hash = Hash.new(0)
    key_letter_hash[:A] = @key.five_digit_key[0..1].to_i
    key_letter_hash[:B] = @key.five_digit_key[1..2].to_i
    key_letter_hash[:C] = @key.five_digit_key[2..3].to_i
    key_letter_hash[:D] = @key.five_digit_key[3..4].to_i
    key_letter_hash
  end

  def assign_letters_to_offset_digits
    key_letter_hash = Hash.new(0)
    key_letter_hash[:A] = @offset.four_digit_offset[0].to_i
    key_letter_hash[:B] = @offset.four_digit_offset[1].to_i
    key_letter_hash[:C] = @offset.four_digit_offset[2].to_i
    key_letter_hash[:D] = @offset.four_digit_offset[3].to_i
    key_letter_hash
  end

  def make_shift_from_key_and_offset
    assign_letters_to_key_digits.merge!(assign_letters_to_offset_digits) {|letter, digit_1, digit_2| digit_1 + digit_2 }
  end

  def create_character_set
    ("a".."z").to_a << " "
  end
end
