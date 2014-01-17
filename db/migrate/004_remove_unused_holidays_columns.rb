#encoding: utf-8
class RemoveUnusedHolidaysColumns < ActiveRecord::Migration
	def up
		remove_columns(:holidays, :typee, :mark, :remark)
	end

	def down
		add_column :holidays, :typee, :integer, :default => 0
		add_column :holidays, :mark, :text
		add_column :holidays, :remark, :text
	end
end
