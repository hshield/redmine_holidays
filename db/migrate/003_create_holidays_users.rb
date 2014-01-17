class CreateHolidaysUsers < ActiveRecord::Migration
	def up
		create_table :holidays_users do |t|
		  t.integer :holiday_id
		  t.integer :user_id
		end
	end

    def down
		drop_table :holidays_users
    end
end
