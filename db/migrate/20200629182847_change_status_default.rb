class ChangeStatusDefault < ActiveRecord::Migration[6.0]
  def change
    change_column_default :catrentalrequests, :status, 'PENDING'
  end
end
