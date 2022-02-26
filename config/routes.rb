Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
	# GET	/api/links	=>  goes to api/links_controller#index
  # POST	/api/links =>  goes to api/links_controller#create
  # GET	/api/links/:id =>	goes to api/links_controller#show
  # PATCH	/api/links/:id => goes to api/links_controller#update
  # PUT	/api/links/:id => goes to api/links_controller#update
  # DELETE	/api/links/:id =>=> goes to api/links_controller#destroy

    # this generate the routes above 
    resources :links
  end
end
