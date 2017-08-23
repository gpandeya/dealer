class CarsController <ApplicationController
    def index
        @cars = Car.all
    end
    
    def show
        
        @car = Car.find(params[:id])
    end
    
    def destroy
       
        car = Car.find(params[:id])
        car.destroy
       
        redirect_to cars_path

    end
    
    def new
        @car = Car.new
    end
    
    def create
        @car = Car.new(params[:car].permit(:vin, :make, :model, :year))
       
        if  @car.save
            redirect_to car_path(@car)
        else
           
            render 'new'
        end
    
    end
    
    def edit
        @car = Car.find(params[:id])
    
    end
    
    def update
        @car = Car.find(params[:id])
        
        @car.vin = params[:car].permit([:vin])
        @car.make = params[:car].permit([:make])
        @car.model = params[:car].permit([:model])
        @car.year = params[:car].permit([:year])
        
       
        
        if  @car.update
            redirect_to car_path(@car)
        else
           
            render 'edit'
        end
        
        
    end
    
    
    
end