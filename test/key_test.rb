require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/classes/enigma'
require './lib/classes/key'
require 'pry'
require 'mocha/minitest'

class KeyTest < Minitest::Test

  def setup
    @key_1 = Key.new("")
    @key_2 = Key.new("222")
  end

  def test_that_it_exists
    assert_instance_of Key, @key_1
  end

  def test_that_it_has_attributes
    assert_equal "", @key_1.user_given_key
    assert_equal "222", @key_2.user_given_key
  end

  def test_generate_random_number
    @key_1.stubs(:generate_random_key).returns("12345")
    assert_equal "12345", @key_1.generate_random_key
  end

  def test_that_random_or_user_key_is_chosen
    @key_1.stubs(:generate_random_key).returns("56789")
    assert_equal "56789", @key_1.determine_the_key_to_use
    assert_equal "00222", @key_2.determine_the_key_to_use
  end

  def test_assign_letters_to_digits
    @key_1.stubs(:generate_random_key).returns("56789")
    expected = {:A=>56, :B=>67, :C=>78, :D=>89}
    expected_2 = {:A=>0, :B=>2, :C=>22, :D=>22}
    assert_equal expected, @key_1.assign_letters_to_digits
    assert_equal expected_2, @key_2.assign_letters_to_digits
  end
end
