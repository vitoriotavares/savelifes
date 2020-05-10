class AddFieldsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :address, :string
    add_column :users, :phone, :string
    add_column :users, :cell_phone, :string
    add_column :users, :cnpj, :string
  end
end
