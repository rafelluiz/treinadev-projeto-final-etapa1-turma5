class Job < ApplicationRecord
  belongs_to :company
  enum level: { junior: 0, full: 1 ,senior: 2}
  enum status: { disabled: 0, enabled: 1}

  has_many :applies
  has_many :candidates, through: :applies

  def apply!(candidate)
    Apply.create!(job:self,candidate:candidate)
    #self.update(total_job:self.total_job-1)
  end

end
