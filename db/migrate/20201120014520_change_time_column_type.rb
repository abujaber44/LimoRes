class ChangeTimeColumnType < ActiveRecord::Migration[6.0]
  def change
    change_column(:reservations, :time, :text)
  end
end
