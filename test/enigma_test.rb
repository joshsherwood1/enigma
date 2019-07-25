require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/classes/key'
require './lib/classes/offset'
require './lib/classes/shift'
require './lib/classes/enigma'
require 'pry'

class EnigmaTest < Minitest::Test

  def setup
    @enigma = Enigma.new
  end

  def test_that_it_exists
    assert_instance_of Enigma, @enigma
  end

  def test_create_character_set
    expected = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l",
    "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w",
    "x", "y", "z", " "]
    assert_equal expected, @enigma.create_character_set
  end

  def test_create_rotated_character_set_a
    expected = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l",
    "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w",
    "x", "y", "z", " "]
    assert_equal expected, @enigma.create_rotated_character_set_a
  end

  # def test_that_it_can_encrypt
  #   assert_equal "aaa", @enigma.encrypt(message, key, date)
  # end
  #
  # def test_that_it_can_decrypt
  #   assert_equal "bbb", @enigma.decrypt(ciphertext, key, date)
  # end
end
