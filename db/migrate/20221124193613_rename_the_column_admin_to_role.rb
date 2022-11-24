# frozen_string_literal: true

class RenameTheColumnAdminToRole < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :admin, :role
    change_column :users, :role, :string
  end
end
