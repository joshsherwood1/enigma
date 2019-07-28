class Shift

  def make_shift_from_key_and_offset(key, offset)
    key.merge!(offset) {|letter, digit_1, digit_2| digit_1 + digit_2 }
  end
end
