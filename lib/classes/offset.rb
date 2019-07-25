require 'date'

class Offset
  attr_reader :user_given_date

  def initialize(user_given_date)
    @user_given_date = user_given_date
  end

  def make_offset_based_off_of_current_date
    current_date = DateTime.now
    current_date_integer = current_date.strftime("%d%m%y").to_i
    current_date_squared = (current_date_integer ** 2).to_s
    current_date_squared.chars.last(4).join
  end

  def make_offset_based_off_of_user_given_date
    user_date_integer = @user_given_date.to_i
    user_date_squared = (user_date_integer ** 2).to_s
    user_date_squared.chars.last(4).join
  end

  def determine_the_offset_to_use
    if @user_given_date == ""
      make_offset_based_off_of_current_date
    else
      make_offset_based_off_of_user_given_date
    end
  end
end
