module Decryption

  def create_character_set_for_decryption
    ("a".."z").to_a << " "
  end

  def create_shift_a_hash_decryption
    a_rotated_character_set = create_character_set.rotate(-(@shift.official_shift[:A]))
    Hash[create_character_set_for_decryption.zip(a_rotated_character_set)]
  end

  def create_shift_b_hash_decryption
    b_rotated_character_set = create_character_set.rotate(-(@shift.official_shift[:B]))
    Hash[create_character_set_for_decryption.zip(b_rotated_character_set)]
  end

  def create_shift_c_hash_decryption
    c_rotated_character_set = create_character_set.rotate(-(@shift.official_shift[:C]))
    Hash[create_character_set_for_decryption.zip(c_rotated_character_set)]
  end

  def create_shift_d_hash_decryption
    d_rotated_character_set = create_character_set.rotate(-(@shift.official_shift[:D]))
    Hash[create_character_set_for_decryption.zip(d_rotated_character_set)]
  end

  def create_array_from_encrypted_message
    @ciphertext.split("")
  end

  def change_a_characters_in_message_decryption
    create_array_from_encrypted_message.map!.with_index do |letter, index|
      if create_shift_a_hash_decryption.keys.include?(letter) == true
        index % 4 == 0 ? create_shift_a_hash_decryption[letter] : letter
      else create_shift_a_hash_decryption.keys.include?(letter) == false
        index % 4 == 0 ? letter : letter
      end
    end
  end

  def change_b_characters_in_message_decryption
    change_a_characters_in_message_decryption.map!.with_index do |letter, index|
      if create_shift_b_hash_decryption.keys.include?(letter) == true
        (index + 3) % 4 == 0 ? create_shift_b_hash_decryption[letter] : letter
      else create_shift_b_hash_decryption.keys.include?(letter) == false
        (index + 3) % 4 == 0 ? letter : letter
      end
    end
  end

  def change_c_characters_in_message_decryption
    change_b_characters_in_message_decryption.map!.with_index do |letter, index|
      if create_shift_c_hash_decryption.keys.include?(letter) == true
        (index + 2) % 4 == 0 ? create_shift_c_hash_decryption[letter] : letter
      else create_shift_c_hash_decryption.keys.include?(letter) == false
        (index + 2) % 4 == 0 ? letter : letter
      end
    end
  end

  def change_d_characters_in_message_decryption
    change_c_characters_in_message_decryption.map!.with_index do |letter, index|
      if create_shift_d_hash_decryption.keys.include?(letter) == true
        (index + 1) % 4 == 0 ? create_shift_d_hash_decryption[letter] : letter
      else create_shift_d_hash_decryption.keys.include?(letter) == false
        (index + 1) % 4 == 0 ? letter : letter
      end
    end
  end

  def convert_decrypted_array_to_string
    change_d_characters_in_message_decryption.join("").to_s
  end

  def create_shift_hashes_and_array_of_encrypted_message
    create_shift_a_hash_decryption
    create_shift_b_hash_decryption
    create_shift_c_hash_decryption
    create_shift_d_hash_decryption
    create_array_from_encrypted_message
  end

  def change_encrypted_message_characters_and_convert_to_string
    change_a_characters_in_message_decryption
    change_b_characters_in_message_decryption
    change_c_characters_in_message_decryption
    change_d_characters_in_message_decryption
    convert_decrypted_array_to_string
  end
end
