require './test/test_helper'
gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/classes/enigma'
require 'csv'
require 'pry'

class EnigmaTest < Minitest::Test

  def setup
    @enigma = Enigma.new
  end

  def test_that_it_exists
    assert_instance_of Enigma, @enigma
  end

  def test_that_it_can_encrypt
    assert_equal "aaa", @enigma.encrypt(message, key, date)
  end

  def test_that_it_can_decrypt
    assert_equal "bbb", @enigma.decrypt(ciphertext, key, date)
  end
end
