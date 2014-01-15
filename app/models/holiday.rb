class Holiday < ActiveRecord::Base
  unloadable

  belongs_to :author, :class_name => "User", :foreign_key => "user_id"
  belongs_to :holiday_types, :foreign_key => "holiday_type_id"
  has_and_belongs_to_many :users

  # Returns a string of css classes that apply to the issue
  def css_classes
    "issue tracker-#{id} status-#{status}"
  end

end
