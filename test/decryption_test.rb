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
      @key_1 = Key.new
      @key_1.stubs(:generate_random_key).returns("56789")
      @key_2 = Key.new
      @offset_1 = Offset.new
      @offset_1.stubs(:make_offset_based_off_of_current_date).returns("6961")
      @offset_2 = Offset.new
      @key_1.determine_the_key_to_use
      @offset_1.determine_the_offset_to_use
      @key_2.determine_the_key_to_use
      @offset_2.determine_the_offset_to_use
      @shift_1 = Shift.new(@key_1, @offset_1)
      @shift_2 = Shift.new(@key_2, @offset_2)
      @shift_2.assign_letters_to_key_digits
      @shift_2.assign_letters_to_offset_digits
      @shift_2.make_shift_from_key_and_offset
      @enigma = Enigma.new(@shift_2.official_shift, @key_2, @offset_2)
  end

  def test_create_character_set_for_decryption
    expected = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l",
    "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w",
    "x", "y", "z", " "]
    assert_equal expected, @enigma.create_character_set_for_decryption
  end

  def test_create_rotated_character_set_a_hash_for_decryption
    expected = {"a"=>"v", "b"=>"w", "c"=>"x", "d"=>"y", "e"=>"z", "f"=>" ",
    "g"=>"a", "h"=>"b", "i"=>"c", "j"=>"d", "k"=>"e", "l"=>"f", "m"=>"g",
    "n"=>"h", "o"=>"i", "p"=>"j", "q"=>"k", "r"=>"l", "s"=>"m", "t"=>"n",
    "u"=>"o", "v"=>"p", "w"=>"q", "x"=>"r", "y"=>"s", "z"=>"t", " "=>"u"}
    assert_equal expected, @enigma.create_rotated_character_set_a_hash_for_decryption
  end

  def test_create_rotated_character_set_b_hash_for_decryption
    expected = {"a"=>"t", "b"=>"u", "c"=>"v", "d"=>"w", "e"=>"x", "f"=>"y",
    "g"=>"z", "h"=>" ", "i"=>"a", "j"=>"b", "k"=>"c", "l"=>"d", "m"=>"e",
    "n"=>"f", "o"=>"g", "p"=>"h", "q"=>"i", "r"=>"j", "s"=>"k", "t"=>"l",
    "u"=>"m", "v"=>"n", "w"=>"o", "x"=>"p", "y"=>"q", "z"=>"r", " "=>"s"}
    assert_equal expected, @enigma.create_rotated_character_set_b_hash_for_decryption
  end

  def test_create_rotated_character_set_c_hash_for_decryption
    expected = {"a"=>"y", "b"=>"z", "c"=>" ", "d"=>"a", "e"=>"b", "f"=>"c",
    "g"=>"d", "h"=>"e", "i"=>"f", "j"=>"g", "k"=>"h", "l"=>"i", "m"=>"j",
    "n"=>"k", "o"=>"l", "p"=>"m", "q"=>"n", "r"=>"o", "s"=>"p", "t"=>"q",
    "u"=>"r", "v"=>"s", "w"=>"t", "x"=>"u", "y"=>"v", "z"=>"w", " "=>"x"}
    assert_equal expected, @enigma.create_rotated_character_set_c_hash_for_decryption
  end

  def test_create_rotated_character_set_d_hash_for_decryption
    expected = {"a"=>"e", "b"=>"f", "c"=>"g", "d"=>"h", "e"=>"i", "f"=>"j",
    "g"=>"k", "h"=>"l", "i"=>"m", "j"=>"n", "k"=>"o", "l"=>"p", "m"=>"q",
    "n"=>"r", "o"=>"s", "p"=>"t", "q"=>"u", "r"=>"v", "s"=>"w", "t"=>"x",
    "u"=>"y", "v"=>"z", "w"=>" ", "x"=>"a", "y"=>"b", "z"=>"c", " "=>"d"}
    assert_equal expected, @enigma.create_rotated_character_set_d_hash_for_decryption
  end

  def test_create_array_of_individual_characters_from_encrypted_message
    @enigma.decrypt("nmohuhzkxtg!", @key_2.five_digit_key, "100493")
    expected = ["n", "m", "o", "h", "u", "h", "z", "k", "x", "t", "g", "!"]
    assert_equal expected, @enigma.create_array_from_encrypted_message
  end

  def test_that_a_characters_are_changed_decryption
    @enigma.decrypt("nmohuhzkxtg!", @key_2.five_digit_key, "100493")
    expected = ["h", "m", "o", "h", "o", "h", "z", "k", "r", "t", "g", "!"]
    assert_equal expected, @enigma.change_a_characters_in_message_decryption
  end

  def test_that_b_characters_are_changed_decryption
    @enigma.decrypt("nmohuhzkxtg!", @key_2.five_digit_key, "100493")
    expected = ["h", "e", "o", "h", "o", " ", "z", "k", "r", "l", "g", "!"]
    assert_equal expected, @enigma.change_b_characters_in_message_decryption
  end

  def test_that_c_characters_are_changed_decryption
    @enigma.decrypt("nmohuhzkxtg!", @key_2.five_digit_key, "100493")
    expected = ["h", "e", "l", "h", "o", " ", "w", "k", "r", "l", "d", "!"]
    assert_equal expected, @enigma.change_c_characters_in_message_decryption
  end

  def test_that_d_characters_are_changed_decryption
    @enigma.decrypt("nmohuhzkxtg!", @key_2.five_digit_key, "100493")
    expected = ["h", "e", "l", "l", "o", " ", "w", "o", "r", "l", "d", "!"]
    assert_equal expected, @enigma.change_d_characters_in_message_decryption
  end

  def test_that_decrypted_message_is_converted_back_to_a_string
    @enigma.decrypt("nmohuhzkxtg!", @key_2.five_digit_key, "100493")
    assert_equal "hello world!", @enigma.convert_decrypted_array_to_string
  end
end
