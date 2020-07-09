class AddUserIdToCatrentalrequests < ActiveRecord::Migration[6.0]
  def change
    add_column :catrentalrequests, :user_id, :integer
    add_index :catrentalrequests, :user_id
  end
end
