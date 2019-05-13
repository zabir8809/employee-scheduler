require 'date'

class Schedule < ApplicationRecord
  belongs_to :employee
  # validates presence of employee_id
  validates :employee, presence: true
  # validates presence of work date
  validates :work_date, presence: true
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
  # validates presence of shift hour and it is less than or equal to 8hrs
  validates :shift_hour, presence: true, inclusion: {in: (0.0..8.0), message: 'cannot be more than 8hrs'}
  # validation to check employee max hours per week not exceeding 40 
  validate :hours_per_week

  private
  # validation to check start_time is always earlier than end_time
  def end_time_must_be_after_start_time
    if self.start_time > self.end_time
      errors.add(:end_time, 'must be after start time')
    end
  end

   # validation to check employee max hours per week not exceeding 40
  def hours_per_week
    condition = Schedule.where(work_date: Date.today-7..Date.today, employee_id: self.employee_id).sum('shift_hour')
    if condition >= 40
      errors.add(:shift_hour, 'must be less than equal to 40 per week')
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