class Apply < ApplicationRecord
  belongs_to :candidate
  belongs_to :job

  enum level: { pending: 0, declined: 1,approved: 2}
end
