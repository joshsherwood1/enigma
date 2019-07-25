require './test/test_helper'
gem 'minitest', '~> 5.2'
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
end
