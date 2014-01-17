class CreateHolidayTypes < ActiveRecord::Migration
	def up
		create_table :holiday_types do |t|
		  t.string :name
		  t.string :color
		  t.datetime :created_at
		end

		#HolidayTypes.create(:name => "Holiday", :color => "#fdc68c")

		# add column to holidays
		add_column :holidays, :holiday_type_id, :integer
	end

    def down
		remove_column :holidays, :holiday_type_id
		drop_table :holiday_types
    end

end
