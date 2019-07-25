require 'date'

class Offset
  attr_reader :four_digit_offset, :chosen_date

  def initialize
    @four_digit_offset = nil
    @chosen_date = chosen_date
  end

  def make_current_date_into_string
    current_date = DateTime.now
    current_date.strftime("%d%m%y").to_s
  end

  def make_offset(date)
    @chosen_date = date
    current_date_integer = date.to_i
    current_date_squared = (current_date_integer ** 2).to_s
    offset = current_date_squared.chars.last(4).join
    @four_digit_offset = offset
  end
end
