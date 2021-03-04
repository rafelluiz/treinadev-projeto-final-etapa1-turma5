class CandidatesController < ApplicationController
  before_action :authenticate_collaborator!, only: %i[show]

  def show
    @candidate = Candidate.find(params[:id])
  end

end
