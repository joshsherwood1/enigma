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

  def create_rotated_character_set_c
    create_character_set.rotate(@shift[:C])
  end

  def create_rotated_character_set_d
    create_character_set.rotate(@shift[:D])
  end

  def encrypt(message, key, date)
    current_date = DateTime.now
    current_date_string = current_date.strftime("%d%m%y").to_s unless date.nil? == false
    chosen_date = current_date_string
    hash = {
    encryption: message,
    key: key,
    date: chosen_date
  }
  end

  def decrypt(ciphertext, key, date)
  end
end
