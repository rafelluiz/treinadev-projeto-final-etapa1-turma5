class CandidatesController < ApplicationController
  before_action :authenticate!, only: %i[show]

  def show
    @candidate = Candidate.find(params[:id])
  end

  private

  def authenticate!
    unless collaborator_signed_in? or candidate_signed_in?
      redirect_to root_path, notice: 'Please login as collaborator or candidate!'
    end
  end

end
