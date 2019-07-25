class Shift
  attr_reader :key, :offset

  def initialize(key, offset)
    @key = key
    @offset = offset
  end

  def make_shift_from_key_and_offset
    key = @key.determine_the_key_to_use.assign_letters_to_digits
    # key_hash = key.assign_letters_to_digits
    # offset = @offset.determine_the_offset_to_use
    # offset_hash = offset.assign_letters_to_offset_digits
    # key_hash.merge!(offset_hash) {|letter, digit_1, digit_2| digit_1 + digit_2 }
  end

  def create_character_set
    ("a".."z").to_a << " "
  end

  def rotate_character_set(rotation_number)
    create_character_set.rotate(rotation_number)
  end

  def assign_letters_to_digits
    key_letter_hash = Hash.new(0)
    key_letter_hash[:A] = determine_the_key_to_use[0..1].to_i
    key_letter_hash[:B] = determine_the_key_to_use[1..2].to_i
    key_letter_hash[:C] = determine_the_key_to_use[2..3].to_i
    key_letter_hash[:D] = determine_the_key_to_use[3..4].to_i
    key_letter_hash
  end
end
