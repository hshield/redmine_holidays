#encoding: utf-8
class HolidaysController < ApplicationController
	model_object Holiday
	unloadable

	before_filter :find_holiday, :only => [:edit, :update, :destroy, :copy]
	before_filter :get_all_holiday_types, :only => [:new, :create, :edit, :update, :copy]
	before_filter :get_users_and_groups, :only => [:new, :create, :edit, :update, :copy]

	helper :gantt

	def index
		# default params
		params[:year] = Date.today.year unless params[:year]
		params[:month] = Date.today.month unless params[:month]
		params[:months] = 6 unless params[:months]
		params[:zoom] = 2 unless params[:zoom]

		# use the holiday type color to display the list
		params[:use_type_color] = "" unless params[:use_type_color]

		# show past holidays
		params[:show_past_holidays] = "" unless params[:show_past_holidays]

		@gantt = Redmine::Helpers::Gantt.new(params)

		@use_type_color = (params[:use_type_color] != "")
		@show_past_holidays = (params[:show_past_holidays] != "")

		# example
		# range: jan 2014 - jun 2014
		# holidays: 25/12/2013 - 3/1/2014	(start_date is out of range)
		# holidays: 25/6/2014 - 3/7/2014	(due_date is out of range)
		condition_clause = Array[
			@gantt.date_from, @gantt.date_to,
			@gantt.date_from, @gantt.date_to
		]
		condition_clause_string = "((start_date BETWEEN ? AND ?) OR (due_date BETWEEN ? AND ?))"

		if !@show_past_holidays
			condition_clause_string = condition_clause_string +
										" AND (due_date >= ?)"
			condition_clause << Date.today
		end

		condition_clause.unshift condition_clause_string

		@holidays = Holiday.all(:conditions => condition_clause,
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

		if !@holiday.errors.empty?
			render :action => "new"
			return
		end

		# save the users
		update_users(params)

		redirect_to holidays_url(), :notice => "Successful"
	end

	# show holiday
	# redirect to edit for now
	def show
		redirect_to :action => "edit", :id => params[:id]
	end

	# edit holiday
	def edit
	end

	# save the updated holiday
	def update
		# update holidays
		if params[:holiday]
			@holiday.update_attributes(params[:holiday]);

			# update the users
			update_users(params)

			if !@holiday.errors.empty?
				render :action => "edit", :id => params[:id]
				return
			end

		end

		# redirect back to list
		redirect_to holidays_url(), :notice => "Successful"
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

		redirect_to holidays_url(), :notice => "Successful"
	end

	private

	def find_holiday
		@holiday = Holiday.find(params[:id])
	end

	def get_all_holiday_types
		@holiday_types = HolidayTypes.all(:order => "name ASC");
	end

	def get_users_and_groups
		@users = User.all(:conditions => ["status = 1"],
							:order => "firstname ASC, lastname ASC")
		@groups = Group.all
	end

	def update_users(params)
		# users is required
		if !params[:holidays_users] || !params[:holidays_users][:user_ids]
			@holiday.errors.add :users, l(:label_is_required)
			return
		end

		# delete existings first, so it can be used to clear existing users
		HolidaysUsers.where("holiday_id = ?", @holiday.id).delete_all

		# add the user one-by-one
		params[:holidays_users][:user_ids].each do |user_id|
			holiday_user_obj = HolidaysUsers.create(:holiday_id => @holiday.id,
													:user_id => user_id)
		end
	end
end
