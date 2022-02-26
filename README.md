# Follow Along

```
$ rails new resources-api -d postgresql --api
$ cd resources-api
$ rails g model link title url username description
$ rails g controller api/links
$ rails db:create db:migrate
```

app/controllers/api/links_controller.rb
```ruby
class Api::LinksController < ApplicationController
    # return all links
    # get 'api/links'
    def index
      # get all links from db
      links = Link.all
      
      #return data
      render json: links 
    end

    # return 1 link
    # get 'api/links/:id'
    def show
        # find the link in the db  with the id in the url  
        link = Link.find(params[:id])
        #return data
       render json: link
    end


    # try to create a link to db
    # post 'api/links/', link: {title, url, username, description}
    def create
       # create new link in memory     
       link = Link.new(link_params)
       # try to save link to db
       if(link.save)
        # if successful create to db return the newly created  link
        render json: link
       else
        #  create  unsuccessful return as a 422 error 
        render json: {errors: link.errors.full_messages}, status: 422
       end
    end

     # try to update a link to db
     # put/patch 'api/links/:id', link: {title, url, username, description}
    def update
        # find the link in the db  with the id in the url   
        link = Link.find(params[:id])
        # try to update link to db
        if(link.update(link_params))
         # if successful update to db return the updated link 
         render json: link
        else
         #  update  unsuccessful return as a 422 error 
         render json: {errors: link.errors.full_messages}, status: 422
        end
     end

    # delete a link to db
    # delete 'api/links/:id'
    def destroy
      # find the link in the db  with the id in the url   
      link = Link.find(params[:id])
     # remove link from db 
      link.destroy()
     # return destroyed link from db 
      render json: link
    end

    private

    def link_params
        params.require(:link).permit(:title, :url, :username, :description)
    end
end
```

config/routes.rb
```ruby
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
```

app/models/link.rb
```ruby
class Link < ApplicationRecord
    # username must be one of these values or it won't save to db
    students = %w(austink brendac jamesy katherine michaelc michealp randyc trinan sharayahh jessican joej )
    validates :username, inclusion: { in: students,
        message: "%{value} is not a valid username" }
end
```

