module ReservationsHelper
    def readable_date(reservation)
        reservation.date.strftime('%a %d %b %Y')
      end
end
