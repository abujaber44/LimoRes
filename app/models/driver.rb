class Driver < ApplicationRecord
    has_many :reservations
    has_many :users, through: :reservations
    validates :name, presence: true
    
    scope :ordered_by_name, -> { order(name: :asc) }
end
