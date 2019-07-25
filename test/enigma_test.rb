require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/classes/key'
require './lib/classes/offset'
require './lib/classes/shift'
require './lib/classes/enigma'
require 'pry'
require 'mocha/minitest'

class EnigmaTest < Minitest::Test

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

  def test_that_it_exists
    assert_instance_of Enigma, @enigma
  end

  def test_that_it_has_attributes
    assert_nil @enigma.message
    expected = {:A=>6, :B=>8, :C=>30, :D=>23}
    assert_equal expected, @enigma.shift
  end

  def test_create_character_set
    expected = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l",
    "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w",
    "x", "y", "z", " "]
    assert_equal expected, @enigma.create_character_set
  end

  def test_create_rotated_character_set_a
    expected = ["g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r",
    "s", "t", "u", "v", "w", "x", "y", "z", " ", "a", "b",
    "c", "d", "e", "f"]
    assert_equal expected, @enigma.create_rotated_character_set_a
  end

  def test_create_rotated_character_set_b
    expected = ["i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t",
    "u", "v", "w", "x", "y", "z", " ", "a", "b", "c", "d",
    "e", "f", "g", "h"]
    assert_equal expected, @enigma.create_rotated_character_set_b
  end

  def test_create_rotated_character_set_c
    expected = ["d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o",
    "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
    " ", "a", "b", "c"]
    assert_equal expected, @enigma.create_rotated_character_set_c
  end

  def test_create_rotated_character_set_d
    expected = ["x", "y", "z", " ", "a", "b", "c", "d", "e", "f", "g", "h",
    "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s",
    "t", "u", "v", "w"]
    assert_equal expected, @enigma.create_rotated_character_set_d
  end

  def test_that_it_can_encrypt
    assert_equal "aaa", @enigma.encrypt("hello world!", @key_2.five_digit_key, "100493")
  end

  def test_that_enigma_now_has_message
    @enigma.encrypt("hello world!", @key_2.five_digit_key, "100493")
    assert_equal "hello world!", @enigma.message
  end
  #
  # def test_that_it_can_decrypt
  #   assert_equal "bbb", @enigma.decrypt(ciphertext, key, date)
  # end
end
