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
    @key_1 = Key.new
    @key_2 = Key.new
    @offset_1 = Offset.new
    @offset_2 = Offset.new
    @key_1.make_key("123")
    @offset_1.make_offset("091281")
    @key_2.make_key("45999")
    @offset_2.make_offset("161116")
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
    assert_nil @shift_1.official_shift
    assert_nil @shift_2.official_shift
  end

  def test_assign_letters_to_key_digits
    expected = {:A=>0, :B=>1, :C=>12, :D=>23}
    expected_2 = {:A=>45, :B=>59, :C=>99, :D=>99}
    assert_equal expected, @shift_1.assign_letters_to_key_digits
    assert_equal expected_2, @shift_2.assign_letters_to_key_digits
  end
  #
  def test_assign_letters_to_offset_digits
    expected = {:A=>0, :B=>9, :C=>6, :D=>1}
    expected_2 = {:A=>5, :B=>4, :C=>5, :D=>6}
    assert_equal expected, @shift_1.assign_letters_to_offset_digits
    assert_equal expected_2, @shift_2.assign_letters_to_offset_digits
  end

  def test_make_shift_from_key_and_offset
    expected = {:A=>0, :B=>10, :C=>18, :D=>24}
    expected_2 = {:A=>50, :B=>63, :C=>104, :D=>105}
    assert_equal expected, @shift_1.make_shift_from_key_and_offset
    assert_equal expected_2, @shift_2.make_shift_from_key_and_offset
  end

  def test_that_official_shift_has_shift
    @shift_1.make_shift_from_key_and_offset
    @shift_2.make_shift_from_key_and_offset
    expected = {:A=>0, :B=>10, :C=>18, :D=>24}
    expected_2 = {:A=>50, :B=>63, :C=>104, :D=>105}
    assert_equal expected, @shift_1.official_shift
    assert_equal expected_2, @shift_2.official_shift
  end
end
