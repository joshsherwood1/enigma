require 'date'

class Enigma
  def create_character_set
    ("a".."z").to_a << " "
  end

  def create_rotated_character_set_a
    create_character_set.rotate()
  end

  def encrypt(message, key, date)
  end

  def decrypt(ciphertext, key, date)
  end
end
