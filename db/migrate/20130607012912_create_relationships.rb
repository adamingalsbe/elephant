class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :principal_id
      t.integer :custodian1_id
      t.integer :custodian2_id
      t.integer :custodian3_id
    end
  end
end
