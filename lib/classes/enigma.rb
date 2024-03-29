require 'date'
require './lib/modules/decryption'
require './lib/modules/encryption'
require './lib/classes/key'
require './lib/classes/offset'
require './lib/classes/shift'
require './lib/classes/enigma'
require 'pry'

class Enigma
  include Decryption, Encryption
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

  def store_shift(shift)
    @shift = shift
  end

  def make_shift
    shift = Shift.new(@key_object, @offset_object)
    store_shift(shift)
    @shift.assign_letters_to_key_digits
    @shift.assign_letters_to_offset_digits
    @shift.make_shift_from_key_and_offset
  end

  def encrypt(message, key = @key_object.generate_random_key, date = @offset_object.make_current_date_into_string)
    store_message_and_make_key_and_object(message, key, date)
    encrypt_message_with_shifts
    hash = {encryption: convert_encrypted_array_to_string, key: @key_object.five_digit_key, date: date}
    @encrypted_text = hash[:encryption]
    hash
  end

  def decrypt(ciphertext, key, date = @offset_object.make_current_date_into_string)
    store_ciphertext_and_make_key_and_object(ciphertext, key, date)
    decrypt_ciphertext_with_shifts
    hash = {decryption: convert_decrypted_array_to_string, key: @key_object.five_digit_key, date: date}
    @decrypted_text = hash[:decryption]
    hash
  end
end
