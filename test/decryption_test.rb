require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/classes/key'
require './lib/classes/offset'
require './lib/classes/shift'
require './lib/classes/enigma'
require './lib/modules/decryption'
require 'pry'
require 'mocha/minitest'

class DecryptionTest < Minitest::Test

  def setup
      @key_1 = Key.new("")
      @key_1.stubs(:generate_random_key).returns("56789")
      @key_2 = Key.new("222")
      @offset_1 = Offset.new("")
      @offset_1.stubs(:make_offset_based_off_of_current_date).returns("6961")
      @offset_2 = Offset.new("071291")
      @key_1.determine_the_key_to_use
      @offset_1.determine_the_offset_to_use
      @key_2.determine_the_key_to_use
      @offset_2.determine_the_offset_to_use
      @shift_1 = Shift.new(@key_1, @offset_1)
      @shift_2 = Shift.new(@key_2, @offset_2)
      @shift_2.assign_letters_to_key_digits
      @shift_2.assign_letters_to_offset_digits
      @shift_2.make_shift_from_key_and_offset
      @enigma = Enigma.new(@shift_2.official_shift)
  end

  def test_create_character_set_for_decryption
    expected = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l",
    "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w",
    "x", "y", "z", " "]
    assert_equal expected, @enigma.create_character_set_for_decryption
  end

  def test_create_rotated_character_set_a_for_decryption
    expected = ["v", "w", "x", "y", "z", " ", "a", "b", "c", "d", "e", "f",
    "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u"]
    assert_equal expected, @enigma.create_rotated_character_set_a_for_decryption
  end

  def test_create_rotated_character_set_b_for_decryption
    expected = ["t", "u", "v", "w", "x", "y", "z", " ", "a", "b", "c", "d",
    "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s"]
    assert_equal expected, @enigma.create_rotated_character_set_b_for_decryption
  end
end