require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/classes/enigma'
require './lib/classes/key'
require './lib/classes/offset'
require 'csv'
require 'pry'
require 'mocha/minitest'

class OffsetTest < Minitest::Test

  def setup
    @offset_1 = Offset.new("")
    @offset_2 = Offset.new("071291")
  end

  def test_that_it_exists
    assert_instance_of Offset, @offset_1
  end

  def test_that_it_has_attributes
    assert_equal "", @offset_1.user_given_date
    assert_equal "071291", @offset_2.user_given_date
  end

  def test_that_it_makes_current_date
    @offset_1.stubs(:make_offset_based_off_of_current_date).returns("6961")
    assert_equal "6961", @offset_1.make_offset_based_off_of_current_date
  end

  def test_that_offset_is_made_with_user_given_date
    assert_equal "6681", @offset_2.make_offset_based_off_of_user_given_date
  end

  def test_determine_to_use_current_date_or_user_date_offset
    @offset_1.stubs(:make_offset_based_off_of_current_date).returns("6961")
    assert_equal "6961", @offset_1.determine_the_offset_to_use
    assert_equal "6681", @offset_2.determine_the_offset_to_use
  end

  def test_assign_letters_to_offset_digits
    expected = {A: "6", B: "9", C: "6", D: "1"}
    expected_2 = {A: "6", B: "6", C: "8", D: "1"}
    assert_equal expected, @offset_1.assign_letters_to_offset_digits
    assert_equal expected_2, @offset_2.assign_letters_to_offset_digits
  end
end
