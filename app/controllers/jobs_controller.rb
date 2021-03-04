class JobsController < ApplicationController
  before_action :set_job, only: %i[show edit update disabled apply]
  before_action :authenticate_collaborator!, only: %i[ new edit update disabled ]
  before_action :authenticate_candidate!, only: %i[ apply ]
  def index
    if collaborator_signed_in?
      collaborator = current_collaborator
      @collaborator_job = collaborator.company
    else
      @companies = Company.all

    end

    @job_search = Job.select('jobs.*,companies.*,jobs.id as id_job').joins(:company).where(
      "name like ? OR title like ? AND status = 1", "%#{params[:q]}%", "%#{params[:q]}%" ).
      select{|item| item.expiration_date.to_date >= Date.today}
  end

  def candidate
    @jobs_company = Job.where(company_id: params[:id]).enabled.
      select{|item| item.expiration_date.to_date >= Date.today}
    @company = Company.find(params[:id])
  end

  def apply
    if @job.apply!(current_candidate)
      redirect_to jobs_path, notice: 'ApplyFor was successful'
    else
      redirect_to jobs_path, notice: 'ApplyFor failed'
    end
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

  def disabled
    @job.disabled!
    redirect_to @job, notice: 'Job was disabled.'
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
