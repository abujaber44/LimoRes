class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :index]

      def index
        @users = User.all
      end
      
      def show
        @user = User.find(params[:id])
      end
    
      def new
        @user = User.new
        @user.addresses.build
      end
    
      def create
        if params[:user][:addresses_attributes] == {"0"=>{"street_address_1"=>"", "street_address_2"=>"", "city"=>"", "state"=>"", "zipcode"=>"", "address_type"=>""}}
          @user = User.new(user_params)
        else
          @user = User.new(user_params_with_address)
        end 
        if @user.save
          log_in @user
          flash[:success] = "Welcome to the LimoRes!"
          redirect_to @user
        else
          render 'new'
        end
      end
    
      private

      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
      end
    
      def user_params_with_address
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin, addresses_attributes: [
          :street_address_1,
          :street_address_2,
          :city,
          :state,
          :zipcode,
          :address_type
        ])
      end
end
