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

Indexes on schedules tables
* A composite unique index was added on start_time and end_time column to enforce one member of staff on shift at a time.
* Another composite index was added on start_time and employee_id to optimize the where clause in the schedule model.
* Index was added on start_time column of schedules table for the sorting in schedules index action.

## To Run on Development Env
* Git clone the repository and cd into it. This will create project specific gemset.
* Run `$ bundle install` followed by `$ rails db:create db:migrate db:seed`
* Run `$ rails s` to start the server. 
* SQlite database is used to keep it lightweight.
* Some seed data is added for demo.

