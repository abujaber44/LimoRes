class Reservation < ApplicationRecord
    belongs_to :user
    belongs_to :driver, optional: true
    validates :date, :time, :pick_up, :drop_off, presence: :true 
    validate :date_cannot_be_in_the_past

  scope :assigned, -> { where.not(:driver_id => nil)}
  scope :archive, -> { where("date < ?", Date.today)}
  scope :future, -> { where("date >= ?", Date.today)}
  

    def date_cannot_be_in_the_past
      if date.present? && date < Date.today
        errors.add(:date, "can't be in the past")
      end
    end    
end










