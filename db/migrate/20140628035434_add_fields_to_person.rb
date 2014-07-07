class AddFieldsToPerson < ActiveRecord::Migration
  def change
    add_column :people, :address, :string
    add_column :people, :city, :string
    add_column :people, :state, :string
    add_column :people, :zip, :string
    add_column :people, :tel, :string
    add_column :people, :email, :string
  end
end
