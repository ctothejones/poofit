class AddSfdcUserIdtoUser < ActiveRecord::Migration
  def change
    add_column :users, :sfdc_user_id, :string
  end
end
