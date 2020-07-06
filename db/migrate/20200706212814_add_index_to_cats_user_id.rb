class AddIndexToCatsUserId < ActiveRecord::Migration[6.0]
  def change
    add_index :cats, :user_id 
  end
end
