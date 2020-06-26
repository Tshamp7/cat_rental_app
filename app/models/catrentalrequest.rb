class Catrentalrequest < ApplicationRecord
    validates :cat_id, presence: true
    validates :start_date, presence: true
    validates :end_date, presence: true
    validates :status, presence: true, inclusion: ["APPROVED","DENIED","PENDING"]

    belongs_to :cat,
    class_name: 'Cat',
    foreign_key: :cat_id,
    primary_key: :id

    def overlapping_requests
      Catrentalrequest.where("catrentalrequests.end_date >= ? ", self.start_date)
      .where("catrentalrequests.cat_id = ?", self.cat_id)
    end
end