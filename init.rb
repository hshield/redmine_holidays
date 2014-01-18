Rails.configuration.to_prepare do
	require_dependency 'patches/user_patch'
end

Redmine::Plugin.register :redmine_holidays do
	name 'Redmine Holidays'
	author 'hshield'
	description 'This is a holidays plugin for Redmine'
	version '0.1.0'
	url 'https://github.com/hshield/redmine_holidays'

	# use project module so it can be configured from roles & permissions in admin.
	# the module per project isn't used
	project_module :holidays do
		permission :view_holidays, { :holidays => [:index] }
		permission :add_holiday, { :holidays => [:new, :create, :copy] }
		permission :edit_holiday, { :holidays => [:show, :edit, :update, :copy] }
		permission :delete_holiday, { :holidays => :destroy }
		permission :manage_holiday_types, { :holiday_types => [:index, :show, :new, :edit, :destroy] }
	end

	menu :top_menu,
		:redmine_holidays,
		{ :controller => 'holidays', :action => 'index' },
		:caption => :label_menu_holidays,
		:if => Proc.new {
			User.current.allowed_to?(:view_holidays, nil, :global => true)
		}
end
