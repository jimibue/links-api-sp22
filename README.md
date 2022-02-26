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



# HEROKU SETUP (API ONLY)
gemfile uncomment cors gem

```
# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem "rack-cors"
```

initializer/config/cors.rb

```
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "*"
    resource "*", headers: :any, methods: [:get, :post, :patch, :put]
  end
end
```

Steps:

- create profile (In rails project folder NOT CLIENT)
`touch Procfile` 
- add this to profile 
`web: bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development}`

- create an app on heroku (need account and need heroku cli)
- login via terminal and add remote

```
$ heroku login
$ heroku git:remote -a your-project-name
```

- to push to heruko

```
$ git add .
$ git commit -m 'initial commit'
$ git push heroku master
$ heroku run rails db:migrate (if needed heroku doesn't
  *if you need to migrate*

```




NEO REFERENCE(You will need to replace your own URL here)
https://dpl.neolms.com/teacher_lesson/show/1687880?lesson_id=7328396&section_id=22724896



Heroku commands:

https://devcenter.heroku.com/articles/heroku-cli-commands (Links to an external site.)
```
$ heroku run rails c
$ heroku open
```


https://heroku.com (Links to an external site.)

https://devcenter.heroku.com/articles/heroku-cli#download-and-install (Links to an external site.)

