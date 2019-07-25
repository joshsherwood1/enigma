require 'date'

class Offset
  def make_offset_based_off_of_current_date
    current_date = DateTime.now
    current_date_integer = current_date.strftime("%d%m%y").to_i
    current_date_squared = (current_date_integer ** 2).to_s
    current_date_squared.chars.last(4).join
  end
end
