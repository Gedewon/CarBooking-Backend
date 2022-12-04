class AddColoumnToCar < ActiveRecord::Migration[7.0]
  def change
    add_column :cars, :car_type, :string
    add_column :cars, :brand, :string
    add_column :cars, :color, :string
    add_index :cars, :car_type
  end
end
