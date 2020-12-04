class ChangeZipcodeType < ActiveRecord::Migration[6.0]
  def change
    change_column :addresses, :zipcode, :string 
  end
end
