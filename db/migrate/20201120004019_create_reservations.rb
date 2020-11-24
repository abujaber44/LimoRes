class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.datetime :date
      t.datetime :time
      t.string :pick_up
      t.string :drop_off
      t.string :vehicle_type
      t.integer :user_id
      t.integer :driver_id

      t.timestamps
    end
  end
end
