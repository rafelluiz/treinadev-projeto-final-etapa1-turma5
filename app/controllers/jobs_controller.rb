class JobsController < ApplicationController
  before_action :set_job, only: %i[show edit update]
  before_action :authenticate_collaborator!
  def index
    collaborator = current_collaborator
    @collaborator_job = collaborator.company
  end

  def show; end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    @job.company = current_collaborator.company
    if @job.save
      redirect_to @job, notice: 'Job was successfully created.'
    else
      render :new ,notice: 'Job could not be created.'
    end
  end

  def edit;end

  def update
    if @job.update(job_params)
      redirect_to @job, notice: 'Job was successfully updated.'
    else
      render :edit, notice: 'Job could not be updated.'
    end
  end

  private

  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:title, :description, :starting_salary_range, :final_salary_range, :level, :requirements,
                                :expiration_date, :total_job,)
  end
end
