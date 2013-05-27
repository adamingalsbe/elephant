class AddUsersBanksToBills < ActiveRecord::Migration
  def change
    add_column :bills, :user_id, :integer
    add_column :bills, :bank_id, :integer
  end
end
