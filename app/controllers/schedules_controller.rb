class SchedulesController < ApplicationController
  before_action :set_schedule, only: [:edit, :update, :destroy]
  before_action :set_employees, only: [:new, :create, :edit, :update]

  # GET /schedules
  def index
    @schedules = Schedule.includes(:employee).order(work_date: :desc)
  end

  # GET /schedules/new
  def new
    @schedule = Schedule.new
  end

  # GET /schedules/1/edit
  def edit
  end

  # POST /schedules
  def create
    @schedule = Schedule.new(schedule_params)
    @schedule.start_time = @schedule.start_time.change(year: @schedule.work_date.year, month: @schedule.work_date.month, day: @schedule.work_date.day)
    @schedule.end_time = @schedule.end_time.change(year: @schedule.work_date.year, month: @schedule.work_date.month, day: @schedule.work_date.day)
    @schedule.shift_hour = (@schedule.end_time - @schedule.start_time)/3600
    if @schedule.save
      redirect_to schedules_path
    else
      flash.now[:alert] = @schedule.errors.full_messages.first.to_s
      render :new
    end
  end

  # PATCH/PUT /schedules/1
  def update
    if @schedule.update(schedule_params)
      @schedule.start_time = @schedule.start_time.change(year: @schedule.work_date.year, month: @schedule.work_date.month, day: @schedule.work_date.day)
      @schedule.end_time = @schedule.end_time.change(year: @schedule.work_date.year, month: @schedule.work_date.month, day: @schedule.work_date.day)
      @schedule.shift_hour = (@schedule.end_time - @schedule.start_time)/3600
      byebug
      flash[:notice] = 'Schedule was successfully updated.'
      redirect_to schedules_path 
    else
      flash.now[:alert] = @schedule.errors.full_messages.first.to_s
      render :edit
    end
  end

  # DELETE /schedules/1
  def destroy
    @schedule.destroy
    flash[:notice] = 'Schedule was successfully destroyed.'
    redirect_to schedules_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_schedule
      @schedule = Schedule.find(params[:id])
    end

    def set_employees
      @employees = Employee.all
    end

    # Only allow a trusted parameter "white list" through.
    def schedule_params
      params.require(:schedule).permit(:work_date, :start_time, :end_time, :employee_id)
    end
end
