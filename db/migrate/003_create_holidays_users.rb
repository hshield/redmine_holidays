class CreateHolidaysUsers < ActiveRecord::Migration
  def change
    create_table :holidays_users do |t|
      t.integer :holiday_id
      t.integer :user_id
    end

    def self.down
		drop_table :holidays_users
    end
  end
end
