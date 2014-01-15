# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

resources :holidays
put "holidays", :to => "holidays#create"
get "holidays/:id/copy", :to => "holidays#copy"

resources :holiday_types
