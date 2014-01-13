class Holiday < ActiveRecord::Base
  unloadable

  belongs_to :author, :class_name => "User", :foreign_key => "user_id"
  belongs_to :holiday_types, :foreign_key => "holiday_type_id"
  has_and_belongs_to_many :users

  # TYPEE = {l(:typee_0) => 0,l(:typee_1) => 1}
  TYPEE = {l(:typee_1) => 1}

  def self.typee_collection
      TYPEE.collect { |s| [s[0], s[1]]}
  end

  # Returns a string of css classes that apply to the issue
  def css_classes
    s = "issue tracker-#{id} status-#{status}"
    s << ' closed' if closed?
    s << ' overdue' if overdue?
    s << ' weeked' if weeked?
    s << ' private' if is_private?
    s << ' created-by-me' if User.current.logged? && user_id == User.current.id
    s
  end

  def closed?
    # self.status.is_closed?
    false
  end

  def weeked?
    self.start_date.cwday == 7
  end

  # Returns true if the issue is overdue
  def overdue?
    !due_date.nil? && (due_date < Date.today)
  end

  def is_private?
    true
  end

end
