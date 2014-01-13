# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
#get 'holidays', :to => 'holidays#index'
#get 'holidays/my', :to => 'holidays#my'
#put 'holidays', :to => 'worklogs#update'

resources :holidays
put "holidays", :to => "holidays#create"
get "holidays/:id/copy", :to => "holidays#copy"

resources :holiday_types
