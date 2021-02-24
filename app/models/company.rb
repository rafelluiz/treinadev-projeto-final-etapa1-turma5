class Company < ApplicationRecord
  has_many :collaborators
  has_many :jobs
end
