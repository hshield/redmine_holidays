#encoding: utf-8
class HolidayTypesController < ApplicationController
	unloadable

	before_filter :find_holiday_type, :only => [:edit, :update, :destroy]

	def index
		@holiday_types = HolidayTypes.all(:order => "name ASC")
	end

	def new
		@holiday_type = HolidayTypes.new
	end

	def create
		@holiday_type = HolidayTypes.new(params[:holiday_types])
		@holiday_type.save

		redirect_to holiday_types_url
	end

	def edit
	end

	def update
		if params[:holiday_types]
			@holiday_type.update_attributes(params[:holiday_types])
		end

		redirect_to holiday_types_url
	end

	def destroy
		@holiday_type.destroy

		redirect_to holiday_types_url
	end

	private

	def find_holiday_type
		@holiday_type = HolidayTypes.find(params[:id])
	end
end
