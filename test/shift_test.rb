require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/classes/enigma'
require './lib/classes/key'
require './lib/classes/offset'
require './lib/classes/shift'
require 'pry'
require 'mocha/minitest'

class ShiftTest < Minitest::Test
  def setup
    @key_1 = Key.new("")
    @key_1.generate_random_key
    @key_1.stubs(:generate_random_key).returns("56789")
    @key_2 = Key.new("222")
    @offset_1 = Offset.new("")
    @offset_1.make_offset_based_off_of_current_date
    @offset_1.stubs(:make_offset_based_off_of_current_date).returns("6961")
    @offset_2 = Offset.new("071291")
    @shift_1 = Shift.new(@key_1, @offset_1)
    @shift_2 = Shift.new(@key_2, @offset_2)
  end

  def test_that_it_exists
    assert_instance_of Shift, @shift_1
  end

  def test_that_it_has_attributes
    assert_equal @key_1, @shift_1.key
    assert_equal @key_2, @shift_2.key
    assert_equal @offset_1, @shift_1.offset
    assert_equal @offset_2, @shift_2.offset
  end

  def test_make_shift_from_key_and_offset

    expected = {:A=>62, :B=>76, :C=>84, :D=>90}
    expected_2 = {:A=>6, :B=>8, :C=>30, :D=>23}
    assert_equal expected, @shift_1.make_shift_from_key_and_offset
    assert_equal expected_2, @shift_2.make_shift_from_key_and_offset
  end

  def test_create_character_set
    expected = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l",
    "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w",
    "x", "y", "z", " "]
    assert_equal expected, @shift_1.create_character_set
  end

  def test_make_key
    assert_equal "00222", @shift_2.make_key
  end

  def test_make_offset
    assert_equal "6681", @shift_2.make_offset
  end

  def test_assign_letters_to_key_digits
    expected = {:A=>56, :B=>67, :C=>78, :D=>89}
    expected_2 = {:A=>0, :B=>2, :C=>22, :D=>22}
    assert_equal expected, @shift_1.assign_letters_to_key_digits
    assert_equal expected_2, @shift_2.assign_letters_to_key_digits
  end
  #
  def test_assign_letters_to_offset_digits
    expected = {:A=>6, :B=>9, :C=>6, :D=>1}
    expected_2 = {A: 6, B: 6, C: 8, D: 1}
    assert_equal expected, @shift_1.assign_letters_to_offset_digits
    assert_equal expected_2, @shift_2.assign_letters_to_offset_digits
  end

  # def test_create_rotated_character_sets
  #   @key_2.determine_the_key_to_use
  #   key_hash_2 = @key_2.assign_letters_to_digits
  #   @offset_2.determine_the_offset_to_use
  #   offset_hash_2 = @offset_2.assign_letters_to_offset_digits
  #   shift = @shift_2.make_shift_from_key_and_offset(key_hash_2, offset_hash_2)
  #   assert_equal [], @shift_2.create_rotated_character_sets
  # end
end
