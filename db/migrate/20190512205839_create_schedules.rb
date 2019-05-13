class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.date :work_date, index: true
      t.datetime :start_time
      t.datetime :end_time
      t.float :shift_hour
      t.references :employee, foreign_key: true

      t.timestamps
    end
    add_index :schedules, [:start_time, :end_time], unique: true
    add_index :schedules, [:work_date, :employee_id]
  end
end
