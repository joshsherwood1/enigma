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
    # @key_1 = Key.new
    # @offset_1 = Offset.new
    # @key_1.make_key("45999")
    # @offset_1.make_offset("161116")
    # @shift_1 = Shift.new(@key_2, @offset_2)
    # @shift_1.assign_letters_to_key_digits
    # @shift_1.assign_letters_to_offset_digits
    # @shift_1.make_shift_from_key_and_offset
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

  def test_that_it_exists
    assert_instance_of Enigma, @enigma
  end

  def test_that_it_has_attributes
    # assert_equal @key_2, @enigma.key_object
    # assert_equal Offset.new, @enigma.offset_object
    assert_nil @enigma.message
    assert_nil @enigma.encrypted_text
    expected = {:A=>6, :B=>8, :C=>30, :D=>23}
    assert_equal @shift_2, @enigma.shift
    @enigma.encrypt("hello world!", "00222", "071291")
    assert_equal "hello world!", @enigma.message
    assert_equal "nmohuhzkxtg!", @enigma.encrypted_text
  end

  def test_create_character_set
    expected = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l",
    "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w",
    "x", "y", "z", " "]
    assert_equal expected, @enigma.create_character_set
  end

  def test_that_it_can_encrypt
    expected = {:encryption=>"nmohuhzkxtg!", :key=>"00222", :date=>"071291"}
    # expected_2 = {:encryption=>"nmohuhzkxtg!", :key=>"00222", :date=>"280719"}
    assert_equal expected, @enigma.encrypt("hello world!", "00222", "071291")
    # assert_equal expected_2, @enigma.encrypt("hello world!", "00222", "071291")
  end

  def test_that_enigma_now_has_message
    @enigma.encrypt("hello world!", "00222", "071291")
    assert_equal "hello world!", @enigma.message
  end

  def test_that_it_can_decrypt
    expected = {:decryption=>"hello world!", :key=>"00222", :date=>"071291"}
    assert_equal expected, @enigma.decrypt("nmohuhzkxtg!", "00222", "071291")
  end
end
