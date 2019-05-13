# Employee Scheduler

## Given Constraints
* Business is open from 7am until 3am, 7 days a week
* There is only one member of staff on shift at a time
* Shifts can be a maximum of 8 hours long
* An employee can work a maximum of 40 hours per week

## Assumptions
Employee clocks out by 2:59am each day.

## Design
* Validations were added on schedule model to apply all the given constraints.
* A composite unique index was added on start_time and end_time column to enforce one member of staff on shift at a time.
* Another composite index was added on work_date and employee_id to optimize the where clause in the schedule model.
* Index was added on work_date column of schedules table for the sorting in schedules index action.

## Improvement
* Some code can be refactored in the schedules_controller to make it DRY.