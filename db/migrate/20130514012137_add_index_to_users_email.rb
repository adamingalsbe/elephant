class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
  	class CreateUsers < ActiveRecord::Migration
create_table :users do |t|
  t.string :first_name
  t.string :last_name
  t.string :email_address
  t.timestamps
end
end

    add_index :users, :email_address, unique: true
  end
end
