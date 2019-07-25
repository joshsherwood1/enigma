class Shift
  attr_reader :key, :offset

  def initialize(key, offset)
    @key = key
    @offset = offset
  end

  def make_key
    @key.determine_the_key_to_use
  end

  def make_offset
    @offset.determine_the_offset_to_use
  end

  def assign_letters_to_key_digits
    key_letter_hash = Hash.new(0)
    key_letter_hash[:A] = make_key[0..1].to_i
    key_letter_hash[:B] = make_key[1..2].to_i
    key_letter_hash[:C] = make_key[2..3].to_i
    key_letter_hash[:D] = make_key[3..4].to_i
    key_letter_hash
  end

  def assign_letters_to_offset_digits
    key_letter_hash = Hash.new(0)
    key_letter_hash[:A] = make_offset[0].to_i
    key_letter_hash[:B] = make_offset[1].to_i
    key_letter_hash[:C] = make_offset[2].to_i
    key_letter_hash[:D] = make_offset[3].to_i
    key_letter_hash
  end

  def make_shift_from_key_and_offset
    assign_letters_to_key_digits.merge!(assign_letters_to_offset_digits) {|letter, digit_1, digit_2| digit_1 + digit_2 }
  end

  def create_character_set
    ("a".."z").to_a << " "
  end
end
