class Company < ApplicationRecord
  has_one_attached :logo
  has_many :collaborators
  has_many :jobs

  before_update :company_updated

  private

  def company_updated
    self.registration_completed = true
  end
end
