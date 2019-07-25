require 'date'

class Offset
  def make_current_date
    today = DateTime.now
    today.strftime("%d%m%y").to_i
  end
end
