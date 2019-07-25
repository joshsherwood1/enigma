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

  def create_array_from_message
    @message.split("")
  end

  def encrypt(message, key, date)
    @message = message
    current_date = DateTime.now
    current_date_string = current_date.strftime("%d%m%y").to_s
    if date.nil? == true || date == ""
      chosen_date = current_date_string
    else date.nil? == false
      chosen_date = date
    end
    hash = {
    encryption: message,
    key: key,
    date: chosen_date
  }
  end

  def create_index_hash_for_a_characters
    Hash[create_character_set.zip(create_rotated_character_set_a)]
  end

  def change_a_characters_in_message
    create_array_from_message.map!.with_index do |letter, index|
      if create_index_hash_for_a_characters.keys.include?(letter) == true
        index % 4 == 0 ? create_index_hash_for_a_characters[letter] : letter
      else create_index_hash_for_a_characters.keys.include?(letter) == false
        index % 4 == 0 ? letter : letter
      end
    end
  end

  def create_index_hash_for_b_characters
    Hash[create_character_set.zip(create_rotated_character_set_b)]
  end

  def change_b_characters_in_message
    change_a_characters_in_message.map!.with_index do |letter, index|
      if create_index_hash_for_b_characters.keys.include?(letter) == true
        (index + 3) % 4 == 0 ? create_index_hash_for_b_characters[letter] : letter
      else create_index_hash_for_b_characters.keys.include?(letter) == false
        (index + 3) % 4 == 0 ? letter : letter
      end
    end
  end



  # def recreate_message_with_a_characters_changed
  #   x = create_rotated_character_set_a.group_by.each_with_index do |item, index|
  #     index % 4
  #   end
  #   x
  # end

  def decrypt(ciphertext, key, date)
  end
end
