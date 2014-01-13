Redmine::Plugin.register :redmine_holidays do
	name 'Holidays'
	author 'Iceskysl'
	description 'This is a holidays plugin for Redmine'
	version '0.1.0'
	url 'https://github.com/IceskYsl/holidays'
	author_url 'http://my.eoe.cn/iceskysl'

	# use project module so it can be configured from roles & permissions in admin.
	# the module per project isn't used
	project_module :holidays do
		permission :view_holidays, { :holidays => [:index, :show] }
		permission :add_holiday, { :holidays => [:new, :copy] }
		permission :edit_holiday, { :holidays => [:edit, :copy] }
		permission :delete_holiday, { :holidays => :destroy }
		permission :manage_holiday_types, { :holiday_types => [:index, :show, :new, :edit, :destroy] }
	end

	menu :top_menu,
		:holidays,
		{ :controller => 'holidays', :action => 'index' },
		:caption => :label_menu_holidays,
		:if => Proc.new {
			User.current.allowed_to?(:view_holidays, nil, :global => true)
		}

	# menu :application_menu, :worklogs, { :controller => 'worklogs', :action => 'index' }, :caption => :label_worklog
	# menu :application_menu, :worklogs_my, { :controller => 'worklogs', :action => 'my'}, :caption => :label_worklog_my ,:if => Proc.new { params[:controller] == "worklogs" }
	# menu :application_menu, :worklogs_new, { :controller => 'worklogs', :action => 'new' }, :caption => :label_worklog_new, :last => true
	# menu :project_menu, :worklogs, { :controller => 'worklogs', :action => 'new' }, :caption => :label_worklog, :before => :activity, :param => :project_id
	#settings :default => {'empty' => true}, :partial => 'settings/holidays_settings'

end
