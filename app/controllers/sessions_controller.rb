class SessionsController < ApplicationController
    def new
    end
  
    def create
      user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        log_in user
        if admin?
          redirect_to future_reservations_path
        else
          redirect_back_or user
        end
      else
        flash.now[:danger] = 'Invalid email/password combination'
        render 'new'
      end
    end
  
    def destroy
      log_out
      redirect_to root_path 
    end

    def google_login
       user_email = request.env['omniauth.auth']['info']['email']
       user_name = request.env['omniauth.auth']['info']['name']
     @user = User.find_or_create_by(email: user_email) do |user|
       user.name = user_name
       user.password = SecureRandom.hex
     end
       log_in @user
       if admin?
        redirect_to future_reservations_path
      else
        redirect_back_or @user
      end
    end
end
