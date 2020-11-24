class ApplicationController < ActionController::Base
  include SessionsHelper

rescue_from CanCan::AccessDenied do |exception|
  redirect_to user_path, :alert => exception.message 
end 
  
  def logged_in_user
    unless params[:id].to_i == current_user.id || admin? 
    flash[:danger] = "You do not have access to this page."
    redirect_to user_path(current_user)
   end
  end 

  # def redirect_if_not_logged_in
  #   if !current_user || params[:id].to_i == current_user.id 
  #     flash[:danger] = "You do not have access to this page."
  #     redirect_to user_path(current_user) 
  #   end
  # end


end
