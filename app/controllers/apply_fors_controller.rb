class ApplyForsController < ApplicationController
  before_action :authenticate_collaborator!, only: %i[index]

  def index
    collaborator = current_collaborator
    @jobs_company = collaborator.company.jobs.enabled

  end
end
