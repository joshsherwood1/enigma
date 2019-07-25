class Shift

  def make_shift_from_key_and_offset(key, offset)
    key.merge!(offset) {|k, v1, v2| v1 +v2 }
  end

end
