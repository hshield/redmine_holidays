#encoding: utf-8
class AddTextColorToHolidayTypes < ActiveRecord::Migration
	def up
		add_column :holiday_types, :text_color, :string, :default => '#000000'
	end

	def down
		remove_column :holiday_types, :text_color
	end
end
