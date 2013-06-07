class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :principal_id
      t.integer :custodian_id
    end
  end
end
