class JobsController < ApplicationController
  before_action :set_job, only: %i[]
  def index;end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)

    if @job.save
      redirect_to @job, notice: 'Job was successfully created.'
    else
      render :new ,notice: 'Job could not be created.'
    end
  end

  private

  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:title, :description, :salary_range, :level, :requirements,
                                :expiration_date, :total_job)
  end
end
