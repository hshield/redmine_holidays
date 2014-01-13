#encoding: utf-8
class HolidayTypesController < ApplicationController
	unloadable

	before_filter :find_holiday_type, :only => [:edit, :update, :destroy]

	def index
		@all_vacations = HolidayTypes.all()
	end

	def new
		@holiday_type = HolidayTypes.new
	end

	def create
		@holiday_type = HolidayTypes.new(params[:holiday_type])
		@holiday_type.save

		redirect_to :index
	end

	def edit
	end

	def update
		if params[:holiday_type]
			@holiday_type.update_attributes(params[:holiday_type])
		end

		redirect_to :index
	end

	def destroy
		@holiday_type.destroy
		redirect_to :index
	end

	private

	def find_holiday_type
		@holiday_type = HolidayTypes.find(params[:id])
	end
end
