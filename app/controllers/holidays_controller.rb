#encoding: utf-8
class HolidaysController < ApplicationController
	model_object Holiday
	unloadable

	before_filter :find_holiday, :only => [:edit, :update, :destroy, :copy]
	before_filter :get_all_vacations, :only => [:new, :edit, :copy]
	before_filter :get_users_and_groups, :only => [:new, :edit, :copy]

	helper :gantt

	def index
		# default params
		params[:year] = Date.today.year unless params[:year]
		params[:month] = Date.today.month unless params[:month]
		params[:months] = 6 unless params[:months]
		params[:zoom] = 2 unless params[:zoom]

		@gantt = Redmine::Helpers::Gantt.new(params)
		#retrieve_query
		#@gantt.query = @query if @query.valid?

		@holidays = Holiday.all(:conditions => ["(start_date >= ?) AND (due_date <= ?)", @gantt.date_from, @gantt.date_to],
								:order => "start_date ASC")
	end

	def new
		@holiday = Holiday.new
		@holiday.start_date = Date.today
		@holiday.due_date = @holiday.start_date
	end

	# create holiday
	def create
		@holiday = Holiday.new(params[:holiday])
		@holiday.author = User.current
		@holiday.save

		# save the users
		update_users(params)

		redirect_to holidays_path()
	end

	# edit holiday
	def edit
		@vacations = HolidayTypes.all;
	end

	# save the updated holiday
	def update
		# update holidays
		if params[:holiday]
			@holiday.update_attributes(params[:holiday]);

			# update the users
			update_users(params)
		end

		# redirect back to list
		redirect_to holidays_path()
	end

	# copy existing holiday
	def copy
		@holiday = @holiday.clone()
		@holiday_users = @holiday.users.clone()

		@holiday.id = 0
		@holiday.users = @holiday_users

		render :new
	end

	# delete holiday
	def destroy
		@holiday.destroy

		redirect_to holidays_path()
	end

	private

	def find_holiday
		@holiday = Holiday.find(params[:id])
	end

	def get_all_vacations
		@vacations = HolidayTypes.all;
	end

	def get_users_and_groups
		@users = User.all(:conditions => ["status = 1"],
							:order => "firstname ASC, lastname ASC")
		@groups = Group.all
	end

	def update_users(params)
		if params[:holidays_users] && params[:holidays_users][:user_ids]
			# delete existings
			HolidaysUsers.where("holiday_id = ?", @holiday.id).delete_all

			# add the user one-by-one
			params[:holidays_users][:user_ids].each do |user_id|
				holiday_user_obj = HolidaysUsers.create(:holiday_id => @holiday.id,
														:user_id => user_id)
			end
		end
	end
end
