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
    @offset_1 = Offset.new
    @offset_2 = Offset.new
  end

  def test_that_it_exists
    assert_instance_of Offset, @offset_1
  end
end
