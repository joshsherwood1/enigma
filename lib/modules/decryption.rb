module Decryption

  def create_character_set_for_decryption
    ("a".."z").to_a << " "
  end

  def create_rotated_character_set_a_for_decryption
    create_character_set.rotate(-(@shift[:A]))
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
    @message.split("")
  end
end
