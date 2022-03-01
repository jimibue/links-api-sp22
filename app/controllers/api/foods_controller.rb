class Api::FoodsController < ApplicationController
    # return all foods
    # get 'api/foods'
    def index
        # get all foods from db
        foods = Food.all
        
        #return data
        render json: foods 
      end
  
      # return 1 food
      # get 'api/foods/:id'
      def show
          # find the food in the db  with the id in the url  
          food = Food.find(params[:id])
          #return data
         render json: food
      end
  
  
      # try to create a food to db
      # post 'api/foods/', food: {name:string, price:float}
      def create
         # create new food in memory     
         food = Food.new(food_params)
         # try to save food to db
         if(food.save)
          # if successful create to db return the newly created  food
          render json: food
         else
          #  create  unsuccessful return as a 422 error 
          render json: {errors: food.errors.full_messages}, status: 422
         end
      end
  
       # try to update a food to db
       # put/patch 'api/foods/:id', food: {name:string, price:float}
      def update
          # find the food in the db  with the id in the url   
          food = Food.find(params[:id])
          # try to update food to db
          if(food.update(food_params))
           # if successful update to db return the updated food 
           render json: food
          else
           #  update  unsuccessful return as a 422 error 
           render json: {errors: food.errors.full_messages}, status: 422
          end
       end
  
      # delete a food to db
      # delete 'api/foods/:id'
      def destroy
        # find the food in the db  with the id in the url   
        food = Food.find(params[:id])
       # remove food from db 
        food.destroy()
       # return destroyed food from db 
        render json: food
      end
  
      private
  
      def food_params
          params.require(:food).permit(:name, :price)
      end
end
