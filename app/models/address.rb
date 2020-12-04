class Address < ApplicationRecord
    belongs_to :user
    validates :street_address_1, :city, :state, :zipcode, :address_type, presence: :true 
    validates_format_of :zipcode, with: %r{\d{5}(-\d{4})?}, message: "should be in the form 12345 or 12345-1234"



    def combine
        self.address_type + ": " + self.street_address_1 + ", " + self.street_address_2 + ", " + self.city + ", " + self.state + " " + self.zipcode 
    end

end


