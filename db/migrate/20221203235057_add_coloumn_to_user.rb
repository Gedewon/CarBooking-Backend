class AddColoumnToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :email, :string
    add_column :users, :image_url, :string
    add_column :users, :date_of_birth, :date
    add_index :users, :image_url
  end
end
