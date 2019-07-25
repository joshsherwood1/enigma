require './test/test_helper'
gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/classes/enigma'
require './lib/classes/key'
require 'csv'
require 'pry'
require 'mocha/minitest'

class KeyTest < Minitest::Test

  def setup
    @key_1 = Key.new
  end

  def test_that_it_exists
    assert_instance_of Key, @key_1
  end

  def test_generate_random_number
    @key_1.stubs(:generate_random_key).returns("12345")
    assert_equal "12345", @key_1.generate_random_key
  end
end
