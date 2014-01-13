class CreateHolidayTypes < ActiveRecord::Migration
  def change
    create_table :holiday_types do |t|
      t.string :name
      t.string :color
      t.datetime :created_at
    end

#	HolidayTypes.reset_column_information
#	reversible do |dir|
#		dir.up {
			# create default entries
			HolidayTypes.create(:name => "Public Holiday", :color => "#fdc68c")
			HolidayTypes.create(:name => "Annual Leave", :color => "#ffffdd")
			HolidayTypes.create(:name => "Sick Leave", :color => "#dcbccf")
#		}
#	end

	# add column to holidays
    add_column :holidays, :holiday_type_id, :integer

    def self.down
		remove_column :holidays, :holiday_type_id
		drop_table :holiday_types
    end
  end
end
