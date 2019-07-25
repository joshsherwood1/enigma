require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/classes/enigma'
require './lib/classes/key'
require './lib/classes/offset'
require './lib/classes/shift'
require 'csv'
require 'pry'
require 'mocha/minitest'

class ShiftTest < Minitest::Test
  def setup
    @key_1 = Key.new("")
    @key_2 = Key.new("222")
    @offset_1 = Offset.new("")
    @offset_2 = Offset.new("071291")
    @shift_1 = Shift.new
    @shift_2 = Shift.new
  end

  def test_that_it_exists
    assert_instance_of Shift, @shift_1
  end

  def test_make_shift_from_key_and_offset
    @key_1.determine_the_key_to_use
    key_hash = @key_1.assign_letters_to_digits
    @offset_1.determine_the_offset_to_use
    offset_hash = @offset_1.assign_letters_to_offset_digits
    assert_equal ({A: "a"}), @shift_1.make_shift_from_key_and_offset(key_hash, offset_hash)
  end
end
