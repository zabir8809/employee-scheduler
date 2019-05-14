class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.datetime :start_time, index: true
      t.datetime :end_time
      t.float :shift_hour
      t.references :employee, foreign_key: true

      t.timestamps
    end
    add_index :schedules, [:start_time, :end_time], unique: true
    add_index :schedules, [:start_time, :employee_id]
  end
end
