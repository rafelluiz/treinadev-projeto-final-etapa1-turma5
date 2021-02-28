class Job < ApplicationRecord
  belongs_to :company
  enum level: { junior: 0, full: 1 ,senior: 2}
  enum status: { disabled: 0, enabled: 1}

  def job_expired?
    self.expiration_date <= Time.now
  end
end
