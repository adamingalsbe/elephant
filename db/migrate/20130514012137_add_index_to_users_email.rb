class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
    add_index :users, :email_address, unique: true
  end
end
