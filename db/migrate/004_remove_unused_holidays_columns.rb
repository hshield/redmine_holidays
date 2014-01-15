#encoding: utf-8
class RemoveUnusedHolidaysColumns < ActiveRecord::Migration
	def change
		remove_columns(:holidays, :typee, :mark, :remark)

		def self.down
			add_column :holidays, :typee, :integer, :default => 0
			add_column :holidays, :mark, :text
			add_column :holidays, :remark, :text
		end

	end
end
