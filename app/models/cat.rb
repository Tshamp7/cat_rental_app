class Cat < ApplicationRecord
  $CAT_COLORS = ["Black", "White", "Calico", "Tan", "Orange", "Gray"]

  validates :birth_date, presence: true
  validates :birth_date, exclusion: ['yyyy/mm/dd']
  validates :name, presence: true
  validates :color, presence: true, inclusion: $CAT_COLORS
  validates :sex, presence: true, inclusion: { in: ["M", "F"] }
  validates :description, presence: true

  def age
    Date.today.year - self.birth_date.year
  end

  has_many :rentals,
  class_name: 'CatRentalRequests',
  foreign_key: :cat_id,
  primary_key: :id,
  dependent: :destroy

  belongs_to :owner,
  class_name: 'User',
  foreign_key: :user_id,
  primary_key: :id
end