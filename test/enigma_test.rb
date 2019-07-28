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
    expected = {:encryption=>"hello world!", :key=>"00222", :date=>"100493"}
    expected_2 = {:encryption=>"hello world!", :key=>"00222", :date=>"280719"}
    assert_equal expected, @enigma.encrypt("hello world!", @key_2.five_digit_key, "100493")
    assert_equal expected_2, @enigma.encrypt("hello world!", @key_2.five_digit_key, "")
  end

  def test_that_enigma_now_has_message
    @enigma.encrypt("hello world!", @key_2.five_digit_key, "100493")
    assert_equal "hello world!", @enigma.message
  end

  def test_create_array_of_individual_characters_from_message
    @enigma.encrypt("hello world!", @key_2.five_digit_key, "100493")
    expected = ["h", "e", "l", "l", "o", " ", "w", "o", "r", "l", "d", "!"]
    assert_equal expected, @enigma.create_array_from_message
  end

  def test_create_index_hash_for_a_characters
    @enigma.encrypt("hello world!", @key_2.five_digit_key, "100493")
    expected = {"a"=>"g", "b"=>"h", "c"=>"i", "d"=>"j", "e"=>"k", "f"=>"l",
    "g"=>"m", "h"=>"n", "i"=>"o", "j"=>"p", "k"=>"q", "l"=> "r",
    "m"=>"s", "n"=>"t", "o"=>"u", "p"=>"v", "q"=>"w", "r"=>"x", "s"=>"y",
    "t"=>"z", "u"=>" ", "v"=>"a", "w"=>"b", "x"=>"c", "y"=>"d", "z"=>"e", " "=>"f"}
    assert_equal expected, @enigma.create_index_hash_for_a_characters
  end

  def test_that_a_characters_are_changed
    @enigma.encrypt("hello world!", @key_2.five_digit_key, "100493")
    expected = ["n", "e", "l", "l", "u", " ", "w", "o", "x", "l", "d", "!"]
    assert_equal expected, @enigma.change_a_characters_in_message
  end

  def test_create_index_hash_for_b_characters
    @enigma.encrypt("hello world!", @key_2.five_digit_key, "100493")
    expected = {"a"=>"i", "b"=>"j", "c"=>"k", "d"=>"l", "e"=>"m", "f"=>"n",
    "g"=>"o", "h"=>"p", "i"=>"q", "j"=>"r", "k"=>"s", "l"=>"t", "m"=>"u",
    "n"=>"v", "o"=>"w", "p"=>"x", "q"=>"y", "r"=>"z", "s"=>" ", "t"=>"a",
    "u"=>"b", "v"=>"c", "w"=>"d", "x"=>"e", "y"=>"f", "z"=>"g", " "=>"h"}
    assert_equal expected, @enigma.create_index_hash_for_b_characters
  end

  def test_that_b_characters_are_changed
    @enigma.encrypt("hello world!", @key_2.five_digit_key, "100493")
    expected = ["n", "m", "l", "l", "u", "h", "w", "o", "x", "t", "d", "!"]
    assert_equal expected, @enigma.change_b_characters_in_message
  end

  def test_create_index_hash_for_c_characters
    @enigma.encrypt("hello world!", @key_2.five_digit_key, "100493")
    expected = {"a"=>"d", "b"=>"e", "c"=>"f", "d"=>"g", "e"=>"h", "f"=>"i",
    "g"=>"j", "h"=>"k", "i"=>"l", "j"=>"m", "k"=>"n", "l"=>"o", "m"=>"p",
    "n"=>"q", "o"=>"r", "p"=>"s", "q"=>"t", "r"=>"u", "s"=>"v", "t"=>"w",
    "u"=>"x", "v"=>"y", "w"=>"z", "x"=>" ", "y"=>"a", "z"=>"b", " "=>"c"}
    assert_equal expected, @enigma.create_index_hash_for_c_characters
  end

  def test_that_c_characters_are_changed
    @enigma.encrypt("hello world!", @key_2.five_digit_key, "100493")
    expected = ["n", "m", "o", "l", "u", "h", "z", "o", "x", "t", "g", "!"]
    assert_equal expected, @enigma.change_c_characters_in_message
  end

  def test_create_index_hash_for_d_characters
    @enigma.encrypt("hello world!", @key_2.five_digit_key, "100493")
    expected = {"a"=>"x", "b"=>"y", "c"=>"z", "d"=>" ", "e"=>"a", "f"=>"b",
    "g"=>"c", "h"=>"d", "i"=>"e", "j"=>"f", "k"=>"g", "l"=>"h", "m"=>"i",
    "n"=>"j", "o"=>"k", "p"=>"l", "q"=>"m", "r"=>"n", "s"=>"o", "t"=>"p",
    "u"=>"q", "v"=>"r", "w"=>"s", "x"=>"t", "y"=>"u", "z"=>"v", " "=>"w"}
    assert_equal expected, @enigma.create_index_hash_for_d_characters
  end

  def test_that_d_characters_are_changed
    @enigma.encrypt("hello world!", @key_2.five_digit_key, "100493")
    expected = ["n", "m", "o", "h", "u", "h", "z", "k", "x", "t", "g", "!"]
    assert_equal expected, @enigma.change_d_characters_in_message
  end

  #
  # def test_that_it_can_decrypt
  #   assert_equal "bbb", @enigma.decrypt(ciphertext, key, date)
  # end
end
