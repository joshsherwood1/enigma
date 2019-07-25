module Encryption
  def create_shift_a_hash
    rotated_character_set_a = create_character_set.rotate(@shift.official_shift[:A])
    Hash[create_character_set.zip(rotated_character_set_a)]
  end

  def create_shift_b_hash
    rotated_character_set_b = create_character_set.rotate(@shift.official_shift[:B])
    Hash[create_character_set.zip(rotated_character_set_b)]
  end

  def create_shift_c_hash
    rotated_character_set_c = create_character_set.rotate(@shift.official_shift[:C])
    Hash[create_character_set.zip(rotated_character_set_c)]
  end

  def create_shift_d_hash
    rotated_character_set_d = create_character_set.rotate(@shift.official_shift[:D])
    Hash[create_character_set.zip(rotated_character_set_d)]
  end

  def create_array_from_message
    @message.split("")
  end

  def change_a_characters_in_message
    create_array_from_message.map!.with_index do |letter, index|
      if create_shift_a_hash.keys.include?(letter) == true
        index % 4 == 0 ? create_shift_a_hash[letter] : letter
      else create_shift_a_hash.keys.include?(letter) == false
        index % 4 == 0 ? letter : letter
      end
    end
  end

  def change_b_characters_in_message
    change_a_characters_in_message.map!.with_index do |letter, index|
      if create_shift_b_hash.keys.include?(letter) == true
        (index + 3) % 4 == 0 ? create_shift_b_hash[letter] : letter
      else create_shift_b_hash.keys.include?(letter) == false
        (index + 3) % 4 == 0 ? letter : letter
      end
    end
  end

  def change_c_characters_in_message
    change_b_characters_in_message.map!.with_index do |letter, index|
      if create_shift_c_hash.keys.include?(letter) == true
        (index + 2) % 4 == 0 ? create_shift_c_hash[letter] : letter
      else create_shift_c_hash.keys.include?(letter) == false
        (index + 2) % 4 == 0 ? letter : letter
      end
    end
  end

  def change_d_characters_in_message
    change_c_characters_in_message.map!.with_index do |letter, index|
      if create_shift_d_hash.keys.include?(letter) == true
        (index + 1) % 4 == 0 ? create_shift_d_hash[letter] : letter
      else create_shift_d_hash.keys.include?(letter) == false
        (index + 1) % 4 == 0 ? letter : letter
      end
    end
  end

  def convert_encrypted_array_to_string
    change_d_characters_in_message.join("").to_s
  end
end
