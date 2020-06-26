class CreateCatrentalrequest < ActiveRecord::Migration[6.0]
  def change
    create_table :catrentalrequests do |t|
      t.integer :cat_id, null: false, index: true
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.string :status, null: false
    end
  end
end
