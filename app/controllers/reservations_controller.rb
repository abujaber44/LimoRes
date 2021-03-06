class ReservationsController < ApplicationController
    #before_action :redirect_if_not_logged_in
    #before_action :set_reservation, only: [:show, :edit, :update, :destroy]
  def new
    @reservation = current_user.reservations.new
    @user = current_user
    @addresses = @user.addresses.all.collect {|a| [a.combine]} 
    @addresses += ["Enter a New Address"]
  end

  def index
    if params[:user_id]
      @reservations = current_user.reservations.future.order("date")
    end 
  end

  def create
    @user = current_user
    @addresses = @user.addresses.all.collect {|a| [a.combine]} 
    @reservation = Reservation.new
    if params[:reservation][:pick_up] == "Enter a New Address" && params[:reservation][:drop_off] == "Enter a New Address"
      @reservation = current_user.reservations.build(date: params[:reservation][:date], time: params[:reservation][:time], pick_up: params[:pick_up_other], drop_off: params[:drop_off_other], vehicle_type: params[:reservation][:vehicle_type] )
    elsif params[:reservation][:pick_up] == "Enter a New Address"
      @reservation = current_user.reservations.build(date: params[:reservation][:date], time: params[:reservation][:time], pick_up: params[:pick_up_other], drop_off: params[:reservation][:drop_off], vehicle_type: params[:reservation][:vehicle_type] )
    elsif params[:reservation][:drop_off] == "Enter a New Address"
      @reservation = current_user.reservations.build(date: params[:reservation][:date], time: params[:reservation][:time], pick_up: params[:reservation][:pick_up], drop_off: params[:drop_off_other], vehicle_type: params[:reservation][:vehicle_type] )
    else
      @reservation = current_user.reservations.build(reservation_params)
    end
    authorize! :create, @reservation
    if @reservation.save
      flash[:success] = "Reservation has been created!"
      redirect_to user_reservation_path(current_user, @reservation)
    else
      render 'new'
    end
  end

  def edit
    @reservation = Reservation.find(params[:id])
    authorize! :update, @reservation
    rescue ActiveRecord::RecordNotFound
    redirect_to(user_path(current_user), :notice => 'Reservation not found')
  end

  def update
    @reservation = Reservation.find(params[:id])
    if @reservation.update_attributes(reservation_params)
      flash[:success] = "Reservation updated"
      redirect_to user_reservation_path(current_user, @reservation)
    else
      render 'edit'
    end
  end

  def edit_choose_drivers
    redirect_to user_path(current_user), warning: "You are not authorized" unless current_user.admin?
    @reservation = Reservation.find(params[:id])
    @drivers = Driver.all.ordered_by_name
  end

  def update_choose_drivers
    @reservation = Reservation.find(params[:id])
    if @reservation.update_attributes(update_driver)
      flash[:success] = "Reservation updated"
      redirect_to future_reservations_url
    else
      flash[:alert] = "Error"
     end
  end

  def destroy
    @reservation = current_user.reservations.find(params[:id])
    if @reservation 
      @reservation.destroy
      flash[:success] = "Reservation has been canceled"
    else
      flash[:alert] = "Error"
    end
    redirect_to user_path(current_user)
  end

  def show
    if params[:user_id]
      @user = User.find_by(id: params[:user_id])
      @reservation = @user.reservations.find_by(id: params[:id])
      authorize! :update, @reservation 
      if @reservation.nil?
        redirect_to user_reservations_path(@user), alert: "Reservation not found"
      end
    else
    @reservation = Reservation.find(params[:id])
    end
  end

  def past_reservations
    if params[:user_id]
      @user = User.find_by(id: params[:user_id])
      @reservations = current_user.reservations.archive.order("date")
    end 
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:date, :time, :pick_up, :drop_off, :vehicle_type, :user_id, :driver_id)
  end

  def update_driver
    params.require(:driver).permit(:driver_id)
  end

end
