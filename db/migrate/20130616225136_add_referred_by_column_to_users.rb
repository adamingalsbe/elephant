class AddReferredByColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :referred_by, :integer
  end
end
