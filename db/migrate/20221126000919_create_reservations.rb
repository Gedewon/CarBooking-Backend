class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :car, null: false, foreign_key: true
      t.datetime :start_date
      t.datetime :end_date
      t.string :city

      t.timestamps
    end
    add_index :reservations, :city
  end
end
