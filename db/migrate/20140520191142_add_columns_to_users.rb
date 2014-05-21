class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_captain, :boolean
    add_column :users, :is_commissioner, :boolean
    add_column :users, :company_id, :integer
    add_column :users, :league_id, :integer
    add_column :users, :team_id, :integer
  end
end
