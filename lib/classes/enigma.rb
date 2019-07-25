require 'date'
require './lib/modules/decryption'
require './lib/classes/key'
require './lib/classes/offset'
require './lib/classes/shift'
require './lib/classes/enigma'
require 'pry'

class Enigma
  include Decryption
  attr_reader :message, :shift, :ciphertext, :encrypted_text, :key_object, :offset_object, :decrypted_text

  def initialize
    @ciphertext = nil
    @message = nil
    @key_object = Key.new
    @offset_object = Offset.new
    @shift = Shift.new(@key_object, @offset_object)
    @encrypted_text = nil
    @decrypted_text = nil
  end

  def create_character_set
    ("a".."z").to_a << " "
  end

  def make_shift_the_official_shift(shift)
    @shift = shift
  end

  def create_rotated_character_set_a
    rotated_character_set_a = create_character_set.rotate(@shift.official_shift[:A])
    Hash[create_character_set.zip(rotated_character_set_a)]
  end

  def create_rotated_character_set_b
    rotated_character_set_b = create_character_set.rotate(@shift.official_shift[:B])
    Hash[create_character_set.zip(rotated_character_set_b)]
  end

  def create_rotated_character_set_c
    rotated_character_set_c = create_character_set.rotate(@shift.official_shift[:C])
    Hash[create_character_set.zip(rotated_character_set_c)]
  end

  def create_rotated_character_set_d
    rotated_character_set_d = create_character_set.rotate(@shift.official_shift[:D])
    Hash[create_character_set.zip(rotated_character_set_d)]
  end

  def create_array_from_message
    @message.split("")
  end

  def encrypt(message, key = @key_object.generate_random_key, date = @offset_object.make_current_date_into_string)
    @message = message
    @key_object.make_key(key)
    @offset_object.make_offset(date)
    shift = Shift.new(@key_object, @offset_object)
    make_shift_the_official_shift(shift)
    @shift.assign_letters_to_key_digits
    @shift.assign_letters_to_offset_digits
    @shift.make_shift_from_key_and_offset
    create_rotated_character_set_a
    create_rotated_character_set_b
    create_rotated_character_set_c
    create_rotated_character_set_d
    create_array_from_message
    change_a_characters_in_message
    change_b_characters_in_message
    change_c_characters_in_message
    change_d_characters_in_message
    convert_encrypted_array_to_string
    hash = {
    encryption: convert_encrypted_array_to_string,
    key: key,
    date: date
    }
    @encrypted_text = hash[:encryption]
    hash
  end

  def change_a_characters_in_message
    create_array_from_message.map!.with_index do |letter, index|
      if create_rotated_character_set_a.keys.include?(letter) == true
        index % 4 == 0 ? create_rotated_character_set_a[letter] : letter
      else create_rotated_character_set_a.keys.include?(letter) == false
        index % 4 == 0 ? letter : letter
      end
    end
  end

  def change_b_characters_in_message
    change_a_characters_in_message.map!.with_index do |letter, index|
      if create_rotated_character_set_b.keys.include?(letter) == true
        (index + 3) % 4 == 0 ? create_rotated_character_set_b[letter] : letter
      else create_rotated_character_set_b.keys.include?(letter) == false
        (index + 3) % 4 == 0 ? letter : letter
      end
    end
  end

  def change_c_characters_in_message
    change_b_characters_in_message.map!.with_index do |letter, index|
      if create_rotated_character_set_c.keys.include?(letter) == true
        (index + 2) % 4 == 0 ? create_rotated_character_set_c[letter] : letter
      else create_rotated_character_set_c.keys.include?(letter) == false
        (index + 2) % 4 == 0 ? letter : letter
      end
    end
  end

  def change_d_characters_in_message
    change_c_characters_in_message.map!.with_index do |letter, index|
      if create_rotated_character_set_d.keys.include?(letter) == true
        (index + 1) % 4 == 0 ? create_rotated_character_set_d[letter] : letter
      else create_rotated_character_set_d.keys.include?(letter) == false
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

  def decrypt(ciphertext, key, date = @offset_object.make_current_date_into_string)
    @ciphertext = ciphertext
    @key_object.make_key(key)
    @offset_object.make_offset(date)
    shift = Shift.new(@key_object, @offset_object)
    make_shift_the_official_shift(shift)
    @shift.assign_letters_to_key_digits
    @shift.assign_letters_to_offset_digits
    @shift.make_shift_from_key_and_offset
    create_rotated_character_set_a_hash_for_decryption
    create_rotated_character_set_b_hash_for_decryption
    create_rotated_character_set_c_hash_for_decryption
    create_rotated_character_set_d_hash_for_decryption
    create_array_from_encrypted_message
    change_a_characters_in_message_decryption
    change_b_characters_in_message_decryption
    change_c_characters_in_message_decryption
    change_d_characters_in_message_decryption
    convert_decrypted_array_to_string
    hash = {
    decryption: convert_decrypted_array_to_string,
    key: key,
    date: date
    }
    @decrypted_text = hash[:decryption]
    hash
  end

end
