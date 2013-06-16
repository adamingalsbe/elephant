class AddEmailVerificationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email_verification, :string
    add_column :users, :email_verified, :boolean
  end
end
