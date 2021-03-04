class Job < ApplicationRecord
  belongs_to :company
  enum level: { junior: 0, full: 1 ,senior: 2}
  enum status: { disabled: 0, enabled: 1}

  has_many :apply_fors
  has_many :candidates, through: :apply_fors

  def apply!(candidate)
    ApplyFor.create!(job:self, candidate:candidate)
    #self.update(total_job:self.total_job-1)
  end

end
