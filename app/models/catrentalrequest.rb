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
      Catrentalrequest
        .where.not(id: self.id)
        .where(cat_id: cat_id)
        .where.not('start_date > :end_date OR end_date < :start_date', start_date: start_date, end_date: end_date)
    end

    def overlapping_approved_request
      overlapping_requests.where("status = 'APPROVED'")
    end

    def approve!
      if does_not_overlap_approved_request && start_and_end_valid?
        self.status = 'APPROVED'
      else
        self.status = 'DENIED'
      end
    end

    def does_not_overlap_approved_request
      return false if overlapping_approved_request.exists?
      return true
    end

    def start_and_end_valid?
      self.start_date < self.end_date ? true : false
    end

end