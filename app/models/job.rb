class Job < ApplicationRecord
  belongs_to :company
  enum level: { junior: 0, full: 1 ,senior: 2}
  enum status: { disabled: 0, enabled: 1}

  has_many :apply_fors
  has_many :candidates, through: :apply_fors




  def apply!(candidate)
    id_job = self.id
    id_candidate = candidate.id
    if ApplyFor.where(candidate_id:id_candidate,job_id:id_job).any?
      errors.add(candidate.full_name,'é candidato a esta vaga.')
      false
    else
      ApplyFor.create!(job:self, candidate:candidate)
      true
    end

    #self.update(total_job:self.total_job-1)
  end
end
