class Company < ApplicationRecord
  has_one_attached :logo
  has_many :collaborators
  has_many :jobs
end
