class HolidayTypes < ActiveRecord::Base
	unloadable

	# default text color
	def default_text_color
		"#000000"
	end
end
