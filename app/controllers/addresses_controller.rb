class AddressesController < ApplicationController

    def new
        @address = current_user.addresses.new
        @user = current_user
      end
    
      def index
        if params[:user_id]
          @addresses = current_user.addresses
        end 
      end
    
      def create
        @user = current_user
        @address = current_user.addresses.build(address_params)
        authorize! :create, @address
        if @address.save
          flash[:success] = "Address has been saved!"
          redirect_to user_address_path(current_user, @address)
        else
          render 'new'
        end
      end
    
      def edit
        @address = Address.find(params[:id])
        authorize! :update, @address
        rescue ActiveRecord::RecordNotFound
        redirect_to(user_path(current_user), :notice => 'Address not found')
      end
    
      def update
        @address = Address.find(params[:id])
        if @address.update_attributes(address_params)
          flash[:success] = "Address updated"
          redirect_to user_address_path(current_user, @address)
        else
          render 'edit'
        end
      end
    
      def destroy
        @address = current_user.addresses.find(params[:id])
        if @address 
          @address.destroy
          flash[:success] = "Address has been deleted"
        else
          flash[:alert] = "Error"
        end
        redirect_to user_path(current_user)
      end
    
      def show
        if params[:user_id]
          @user = User.find_by(id: params[:user_id])
          @address = @user.addresses.find_by(id: params[:id])
          authorize! :update, @address 
          if @address.nil?
            redirect_to user_addresses_path(@user), alert: "Address not found"
          end
        else
        @address = Address.find(params[:id])
        end
      end
    
      private
    
      def set_address
        @address = Address.find(params[:id])
      end
    
      def address_params
        params.require(:address).permit(:street_address_1, :street_address_2, :city, :state, :zipcode, :address_type, :user_id)
      end
    
end
