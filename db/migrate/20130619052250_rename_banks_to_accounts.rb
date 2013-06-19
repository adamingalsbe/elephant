class RenameBanksToAccounts < ActiveRecord::Migration
  def change
      rename_table :banks, :accounts
  end
end
