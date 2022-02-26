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
