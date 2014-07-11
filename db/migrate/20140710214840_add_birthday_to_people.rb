class AddBirthdayToPeople < ActiveRecord::Migration
  def change
    add_column :people, :birthday, :datetime
  end
end
