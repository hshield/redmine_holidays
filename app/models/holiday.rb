class Holiday < ActiveRecord::Base
	unloadable

	belongs_to :author, :class_name => "User", :foreign_key => "user_id"
	belongs_to :holiday_types, :foreign_key => "holiday_type_id"
	has_and_belongs_to_many :users

	validates :title, :presence => true
	validates_associated :users

	# Returns a string of css classes that apply to the issue
	def css_classes
		"issue tracker-#{id} status-#{status}"
	end

	# get all holidays from specific date range
	# @param	date_from
	# @param	date_end
	# @param	show_past_holidays
	def self.search(date_from, date_to, show_past_holidays = false)
		# example
		# range: jan 2014 - jun 2014
		# holidays: 25/12/2013 - 3/1/2014	(start_date is out of range)
		# holidays: 25/6/2014 - 3/7/2014	(due_date is out of range)
		condition_clause = Array[
			date_from, date_to,
			date_from, date_to
		]
		condition_clause_string = "((start_date BETWEEN ? AND ?) OR (due_date BETWEEN ? AND ?))"

		if !show_past_holidays
			condition_clause_string = condition_clause_string +
										" AND (due_date >= ?)"
			condition_clause << Date.today
		end

		condition_clause.unshift condition_clause_string

		return self.all(:conditions => condition_clause,
						:order => "start_date ASC")
	end
end
