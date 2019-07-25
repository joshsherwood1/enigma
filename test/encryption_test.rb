require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/classes/key'
require './lib/classes/offset'
require './lib/classes/shift'
require './lib/classes/enigma'
require './lib/modules/decryption'
require './lib/modules/encryption'
require 'pry'
require 'mocha/minitest'

class EncryptionTest < Minitest::Test
  def setup
    @key_2 = Key.new
    @offset_2 = Offset.new
    @key_2.make_key("222")
    @offset_2.make_offset("071291")
    @shift_2 = Shift.new(@key_2, @offset_2)
    @shift_2.assign_letters_to_key_digits
    @shift_2.assign_letters_to_offset_digits
    @shift_2.make_shift_from_key_and_offset
    @enigma = Enigma.new
    @enigma.make_shift_the_official_shift(@shift_2)
  end

  def test_create_shift_a_hash
    expected = {"a"=>"g", "b"=>"h", "c"=>"i", "d"=>"j", "e"=>"k", "f"=>"l",
    "g"=>"m", "h"=>"n", "i"=>"o", "j"=>"p", "k"=>"q", "l"=>"r", "m"=>"s",
    "n"=>"t", "o"=>"u", "p"=>"v", "q"=>"w", "r"=>"x", "s"=>"y", "t"=>"z",
    "u"=>" ", "v"=>"a", "w"=>"b", "x"=>"c", "y"=>"d", "z"=>"e", " "=>"f"}
    assert_equal expected, @enigma.create_shift_a_hash
  end

  def test_create_shift_b_hash
    expected = {"a"=>"i", "b"=>"j", "c"=>"k", "d"=>"l", "e"=>"m", "f"=>"n",
    "g"=>"o", "h"=>"p", "i"=>"q", "j"=>"r", "k"=>"s", "l"=>"t", "m"=>"u",
    "n"=>"v", "o"=>"w", "p"=>"x", "q"=>"y", "r"=>"z", "s"=>" ", "t"=>"a",
    "u"=>"b", "v"=>"c", "w"=>"d", "x"=>"e", "y"=>"f", "z"=>"g", " "=>"h"}
    assert_equal expected, @enigma.create_shift_b_hash
  end

  def test_create_shift_c_hash
    expected = {"a"=>"d", "b"=>"e", "c"=>"f", "d"=>"g", "e"=>"h", "f"=>"i",
    "g"=>"j", "h"=>"k", "i"=>"l", "j"=>"m", "k"=>"n", "l"=>"o", "m"=>"p",
    "n"=>"q", "o"=>"r", "p"=>"s", "q"=>"t", "r"=>"u", "s"=>"v", "t"=>"w",
    "u"=>"x", "v"=>"y", "w"=>"z", "x"=>" ", "y"=>"a", "z"=>"b", " "=>"c"}
    assert_equal expected, @enigma.create_shift_c_hash
  end

  def test_create_shift_d_hash
    expected = {"a"=>"x", "b"=>"y", "c"=>"z", "d"=>" ", "e"=>"a", "f"=>"b",
    "g"=>"c", "h"=>"d", "i"=>"e", "j"=>"f", "k"=>"g", "l"=>"h", "m"=>"i",
    "n"=>"j", "o"=>"k", "p"=>"l", "q"=>"m", "r"=>"n", "s"=>"o", "t"=>"p",
    "u"=>"q", "v"=>"r", "w"=>"s", "x"=>"t", "y"=>"u", "z"=>"v", " "=>"w"}
    assert_equal expected, @enigma.create_shift_d_hash
  end

  def test_create_array_of_individual_characters_from_message
    @enigma.encrypt("hello world!", "00222", "071291")
    expected = ["h", "e", "l", "l", "o", " ", "w", "o", "r", "l", "d", "!"]
    assert_equal expected, @enigma.create_array_from_message
  end

  def test_that_a_characters_are_changed
    @enigma.encrypt("hello world!", "00222", "071291")
    expected = ["n", "e", "l", "l", "u", " ", "w", "o", "x", "l", "d", "!"]
    assert_equal expected, @enigma.change_a_characters_in_message
  end

  def test_that_b_characters_are_changed
    @enigma.encrypt("hello world!", "00222", "071291")
    expected = ["n", "m", "l", "l", "u", "h", "w", "o", "x", "t", "d", "!"]
    assert_equal expected, @enigma.change_b_characters_in_message
  end

  def test_that_c_characters_are_changed
    @enigma.encrypt("hello world!", "00222", "071291")
    expected = ["n", "m", "o", "l", "u", "h", "z", "o", "x", "t", "g", "!"]
    assert_equal expected, @enigma.change_c_characters_in_message
  end

  def test_that_d_characters_are_changed
    @enigma.encrypt("hello world!", "00222", "071291")
    expected = ["n", "m", "o", "h", "u", "h", "z", "k", "x", "t", "g", "!"]
    assert_equal expected, @enigma.change_d_characters_in_message
  end

  def test_that_encrypted_message_is_converted_back_to_a_string
    @enigma.encrypt("hello world!", "00222", "071291")
    assert_equal "nmohuhzkxtg!", @enigma.convert_encrypted_array_to_string
  end
end
