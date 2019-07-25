require 'date'

class Enigma
  attr_reader :message, :shift

  def initialize(shift)
    @message = nil
    @shift = shift
  end

  def create_character_set
    ("a".."z").to_a << " "
  end

  def create_rotated_character_set_a
    create_character_set.rotate(@shift[:A])
  end

  def create_rotated_character_set_b
    create_character_set.rotate(@shift[:B])
  end

  def encrypt(message, key, date)
  end

  def decrypt(ciphertext, key, date)
  end
end
