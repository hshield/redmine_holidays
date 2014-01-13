class HolidaysUsers < ActiveRecord::Base
  unloadable

  belongs_to :holidays
  belongs_to :users
end
