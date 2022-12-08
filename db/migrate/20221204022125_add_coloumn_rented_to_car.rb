class AddColoumnRentedToCar < ActiveRecord::Migration[7.0]
  def change
    add_column :cars, :rented, :boolean ,default: false
    add_index :cars, :rented
  end
end
