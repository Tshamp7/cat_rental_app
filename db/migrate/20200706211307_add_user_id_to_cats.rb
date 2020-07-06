class AddUserIdToCats < ActiveRecord::Migration[6.0]
  def change
    add_column :cats, :user_id, :integer, index: true
  end
end
