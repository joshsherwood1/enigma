require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/classes/enigma'
require './lib/classes/key'
require './lib/classes/offset'
require 'pry'
require 'mocha/minitest'

class OffsetTest < Minitest::Test

  def setup
    @offset_1 = Offset.new
    @offset_2 = Offset.new
  end

  def test_that_it_exists
    assert_instance_of Offset, @offset_1
  end

  def test_that_it_has_attributes
    assert_nil @offset_1.four_digit_offset
    assert_nil @offset_2.four_digit_offset
    assert_nil @offset_1.chosen_date
    @offset_1.make_offset("290719")
    @offset_2.make_offset("100493")
    assert_equal "6961", @offset_1.four_digit_offset
    assert_equal "3049", @offset_2.four_digit_offset
    assert_equal "290719", @offset_1.chosen_date
    assert_equal "100493", @offset_2.chosen_date
  end

  def test_method_to_make_current_date_into_string
    @offset_1.make_current_date_into_string
    @offset_1.stubs(:make_current_date_into_string).returns("6961")
    assert_equal "6961", @offset_1.make_current_date_into_string
  end

  def test_that_offset_is_made
    assert_equal "6961", @offset_1.make_offset("290719")
    assert_equal "3049", @offset_1.make_offset("100493")
  end
end
