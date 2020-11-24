class DriversController < ApplicationController
    before_action :logged_in_user, only: [:show, :index, :new]

    def index  
        @drivers = Driver.ordered_by_name
    end

    def show
        @driver = Driver.find(params[:id])
    end

    def new
        @driver = Driver.new 
    end

    def create 
        @driver = Driver.new(driver_params)
        if @driver.save
          flash[:success] = "Driver Added!!!"
          redirect_to drivers_path 
        else
          render 'new'
        end
    end

    private

    def driver_params
        params.require(:driver).permit(:name)
    end
    
    
end
