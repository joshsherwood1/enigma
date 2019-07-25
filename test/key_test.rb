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
    assert_nil @key_1.five_digit_key
    assert_nil @key_2.five_digit_key
    @key_1.make_key("101")
    @key_2.make_key("45678")
    assert_equal "00101", @key_1.five_digit_key
    assert_equal "45678", @key_2.five_digit_key
  end

  def test_generate_random_number
    @key_1.generate_random_key
    @key_1.stubs(:generate_random_key).returns("12345")
    assert_equal "12345", @key_1.generate_random_key
  end

  def test_make_key
    assert_equal "00222", @key_1.make_key("222")
  end
end
