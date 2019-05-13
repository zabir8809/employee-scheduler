class Employee < ApplicationRecord
  has_many :schedules, dependent: :destroy
end
