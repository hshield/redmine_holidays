#encoding: utf-8
class AddTextColorToHolidayTypes < ActiveRecord::Migration
	def change
		add_column :holiday_types, :text_color, :string, :default => '#000000'
	end
end
