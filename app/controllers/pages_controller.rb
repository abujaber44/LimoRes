class PagesController < ApplicationController
  def home
  end

  def future_reservations
     if current_user
      redirect_to user_path(current_user), warning: "You are not authorized" unless current_user.admin?
      @reservations = Reservation.future.order("date") 
      @drivers = Driver.all.ordered_by_name
     else
      redirect_to root_path
     end 
  end

  def archived_reservations
     if current_user
      redirect_to user_path(current_user), warning: "You are not authorized" unless current_user.admin?
      @reservations = Reservation.archive.order("date") 
      @drivers = Driver.all.ordered_by_name
     else
      redirect_to root_path
     end 
  end

end 
    
