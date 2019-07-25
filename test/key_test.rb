require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/classes/enigma'
require './lib/classes/key'
require 'pry'
require 'mocha/minitest'

class KeyTest < Minitest::Test

  def setup
    @key_1 = Key.new
    @key_2 = Key.new
  end

  def test_that_it_exists
    assert_instance_of Key, @key_1
  end

  def test_that_it_has_attributes
    assert_nil @key_1.user_given_key
    assert_nil @key_2.user_given_key
    assert_nil @key_1.five_digit_key
    assert_nil @key_2.five_digit_key
  end

  def test_generate_random_number
    @key_1.stubs(:generate_random_key).returns("12345")
    assert_equal "12345", @key_1.generate_random_key
  end

  def test_that_five_digit_key_has_key
    @key_1.stubs(:generate_random_key).returns("56789")
    @key_1.determine_the_key_to_use
    @key_2.determine_the_key_to_use
    assert_equal "56789", @key_1.five_digit_key
    assert_equal "00222", @key_2.five_digit_key
  end

  def test_make_key
    assert_equal "00222", @key_1.make_key("222")
  end
end
