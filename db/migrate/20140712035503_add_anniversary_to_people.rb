class AddAnniversaryToPeople < ActiveRecord::Migration
  def change
    add_column :people, :anniversary, :datetime
  end
end
