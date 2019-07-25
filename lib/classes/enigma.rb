require 'date'
require './lib/modules/decryption'
require './lib/classes/key'
require './lib/classes/offset'
require './lib/classes/shift'
require './lib/classes/enigma'
require 'pry'

class Enigma
  include Decryption
  attr_reader :message, :shift, :ciphertext, :encrypted_text, :key_object, :offset_object

  def initialize(shift, key_object, offset_object)
    @message = nil
    @shift = Shift.new(@key_object, @offset_object)
    @ciphertext = nil
    @encrypted_text = nil
    @key_object = Key.new
    @offset_object = Offset.new
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

  def encrypt(message, key = @key_object.generate_random_key, date = @offset_object.make_current_date_into_string)
    @message = message
    date = @offset_object.user_given_date
    @key_object.make_key(key)
    @offset_object.make_offset(date)
    date_squared = (date.to_i ** 2).to_s
    offset = date_squared.chars.last(4).join
    create_rotated_character_set_a
    create_rotated_character_set_b
    create_rotated_character_set_c
    create_rotated_character_set_d
    create_array_from_message
    create_index_hash_for_a_characters
    change_a_characters_in_message
    create_index_hash_for_b_characters
    change_b_characters_in_message
    create_index_hash_for_c_characters
    change_c_characters_in_message
    create_index_hash_for_d_characters
    change_d_characters_in_message
    convert_encrypted_array_to_string
    hash = {
    encryption: convert_encrypted_array_to_string,
    key: five_digit_key,
    date: date
    }
    @encrypted_text = hash[:encryption]
    hash
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

  def create_index_hash_for_c_characters
    Hash[create_character_set.zip(create_rotated_character_set_c)]
  end

  def change_c_characters_in_message
    change_b_characters_in_message.map!.with_index do |letter, index|
      if create_index_hash_for_c_characters.keys.include?(letter) == true
        (index + 2) % 4 == 0 ? create_index_hash_for_c_characters[letter] : letter
      else create_index_hash_for_c_characters.keys.include?(letter) == false
        (index + 2) % 4 == 0 ? letter : letter
      end
    end
  end

  def create_index_hash_for_d_characters
    Hash[create_character_set.zip(create_rotated_character_set_d)]
  end

  def change_d_characters_in_message
    change_c_characters_in_message.map!.with_index do |letter, index|
      if create_index_hash_for_d_characters.keys.include?(letter) == true
        (index + 1) % 4 == 0 ? create_index_hash_for_d_characters[letter] : letter
      else create_index_hash_for_d_characters.keys.include?(letter) == false
        (index + 1) % 4 == 0 ? letter : letter
      end
    end
  end

  def convert_encrypted_array_to_string
    change_d_characters_in_message.join("").to_s
  end



  # def recreate_message_with_a_characters_changed
  #   x = create_rotated_character_set_a.group_by.each_with_index do |item, index|
  #     index % 4
  #   end
  #   x
  # end

  def decrypt(ciphertext, key, date)
    @ciphertext = ciphertext
    current_date = DateTime.now
    current_date_string = current_date.strftime("%d%m%y").to_s
    if date.nil? == true || date == ""
      chosen_date = current_date_string
    else date.nil? == false
      chosen_date = date
    end
    hash = {
    encryption: "s",
    key: key,
    date: chosen_date
  }
  end

end
