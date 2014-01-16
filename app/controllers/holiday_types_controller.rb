#encoding: utf-8
class HolidayTypesController < ApplicationController
	unloadable

	before_filter :find_holiday_type, :only => [:edit, :update, :destroy]

	def index
		@holiday_types = HolidayTypes.all(:order => "name ASC")
	end

	def new
		params[:holiday_types] = {} unless params[:holiday_types]

		@holiday_type = HolidayTypes.new(params[:holiday_types])
	end

	def create
		@holiday_type = HolidayTypes.new(params[:holiday_types])
		@holiday_type.save

		if !@holiday_type.valid?
			render :action => 'new'
			return
		end

		redirect_to holiday_types_url, :notice => "Successful"
	end

	# there is no need to display holiday_type
	# This will redirect to edit
	def show
		redirect_to :action => "edit", :id => params[:id]
	end

	def edit
	end

	def update
		if params[:holiday_types]
			@holiday_type.update_attributes(params[:holiday_types])

			if !@holiday_type.valid?
				render :action => "edit", :id => params[:id]
				return
			end
		end

		redirect_to holiday_types_url, :notice => "Successful"
	end

	def destroy
		@holiday_type.destroy

		message = "Successful"
		message = "Error deleting this type" if !@holiday_type.errors.empty?

		redirect_to holiday_types_url, :notice => message
	end

	private

	def find_holiday_type
		@holiday_type = HolidayTypes.find(params[:id])
	end
end
