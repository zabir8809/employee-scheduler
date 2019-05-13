require 'date'
require 'time'

employees = ['zabir', 'sam', 'paul']
employees.each {|i| Employee.create!(name: i)}

schedules = [
  {work_date: Date.today-7, start_time: Time.zone.parse("#{Date.today-7} 7am"), end_time: Time.zone.parse("#{Date.today-7} 3pm"), shift_hour: 8, employee_id: 1},
  {work_date: Date.today-6, start_time: Time.zone.parse("#{Date.today-6} 8am"), end_time: Time.zone.parse("#{Date.today-6} 4pm"), shift_hour: 8, employee_id: 1},
  {work_date: Date.today-5, start_time: Time.zone.parse("#{Date.today-5} 7am"), end_time: Time.zone.parse("#{Date.today-5} 3pm"), shift_hour: 8, employee_id: 1},
  {work_date: Date.today-4, start_time: Time.zone.parse("#{Date.today-4} 7am"), end_time: Time.zone.parse("#{Date.today-4} 3pm"), shift_hour: 8, employee_id: 1},
  {work_date: Date.today-3, start_time: Time.zone.parse("#{Date.today-3} 8am"), end_time: Time.zone.parse("#{Date.today-3} 4pm"), shift_hour: 8, employee_id: 1},
  {work_date: Date.today-2, start_time: Time.zone.parse("#{Date.today-2} 8am"), end_time: Time.zone.parse("#{Date.today-2} 4pm"), shift_hour: 8, employee_id: 2},
  {work_date: Date.today-1, start_time: Time.zone.parse("#{Date.today-1} 11am"), end_time: Time.zone.parse("#{Date.today-1} 4pm"), shift_hour: 5, employee_id: 3}
]

schedules.each do |i|
  Schedule.create!(
    work_date: i[:work_date],
    start_time: i[:start_time],
    end_time: i[:end_time],
    shift_hour: i[:shift_hour],
    employee_id: i[:employee_id]
  )
end

