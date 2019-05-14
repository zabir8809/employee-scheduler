require 'date'

class Schedule < ApplicationRecord
  belongs_to :employee
  # validates presence of employee_id
  validates :employee, presence: true
  # validates presence of start_time
  validates :start_time, presence: true
  # validates no shift hour starting between 7am and 3am
  validate :shift_start_hour
  # validates presence of end_time
  validates :end_time, presence: true
  # validates no shift hour ending between 7am and 3am
  validate :shift_end_hour
  # validation to check start_time is always earlier than end_time 
  validate :end_time_must_be_after_start_time
  # validation to check only one employee working in a given shift. Database level validation is also added as compound index
  validates :start_time, uniqueness: { scope: :end_time, message: 'shift already taken'}
  # validates shift hour and it is less than or equal to 8hrs
  validate :shift_length
  # validation to check employee max hours per week not exceeding 40 
  validate :total_hours_per_week

  before_validation :calculate_shift_hour, on: [:create, :update]

  def calculate_shift_hour  
    shift_hour = (self.end_time-self.start_time)/3600
    self.assign_attributes({shift_hour: shift_hour})
  end
  
  private
  # validation to check start_time is always earlier than end_time
  def end_time_must_be_after_start_time
    if self.start_time > self.end_time
      errors.add(:end_time, 'must be after start time')
    end
  end
  
  def shift_length
    if (self.end_time-self.start_time)/3600 > 8
      errors.add(:shift_hour, 'shift must be less than equal to 8 hrs')
    end
  end
   # validation to check employee max hours per week not exceeding 40
  def total_hours_per_week
    exsisting_shift_hour = Schedule.where(start_time: Date.today-7..Date.today, employee_id: self.employee_id).sum('shift_hour')
    current_shift_hour = (self.end_time - self.start_time)/3600
    if (current_shift_hour + exsisting_shift_hour) > 40
      errors.add(:start_time, 'must be less than equal to 40 per week')
    end
  end

  # validation to check shift hour always starting between 7am and 3am
  def shift_start_hour
    if self.start_time.hour > 2 && self.start_time.hour < 7
      errors.add(:start_time, 'must be between 7am and 2am')
    end  
  end

  # validation to check shift hour always ending between 7am and 3am
  def shift_end_hour
    if self.start_time.hour >= 0 && self.start_time.hour <= 2 && self.end_time.hour > 2 
      errors.add(:end_time, 'must be between 7am and 3am')
    end
    if self.end_time.hour > 2 && self.end_time.hour < 7
      errors.add(:end_time, 'must be between 7am and 3am')
    end 
  end
end