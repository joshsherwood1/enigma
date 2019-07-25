module Decryption

  def create_character_set_for_decryption
    ("a".."z").to_a << " "
  end

  def create_rotated_character_set_a_hash_for_decryption
    a_rotated_character_set = create_character_set.rotate(-(@shift[:A]))
    Hash[create_character_set_for_decryption.zip(a_rotated_character_set)]
  end

  def create_rotated_character_set_b_for_decryption
    create_character_set.rotate(-(@shift[:B]))
  end

  def create_rotated_character_set_c_for_decryption
    create_character_set.rotate(-(@shift[:C]))
  end

  def create_rotated_character_set_d_for_decryption
    create_character_set.rotate(-(@shift[:D]))
  end

  def create_array_from_encrypted_message
    @ciphertext.split("")
  end
end
