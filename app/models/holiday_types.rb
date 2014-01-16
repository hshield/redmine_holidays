class HolidayTypes < ActiveRecord::Base
	unloadable

	validates :name, :color, :text_color, :presence => true
	validates :color, :text_color, :format => {
		:with => /^#[a-fA-F0-9]{6}$/, :message => l(:label_invalid_color)
	}

	# default text color
	def default_text_color
		"#000000"
	end
end
