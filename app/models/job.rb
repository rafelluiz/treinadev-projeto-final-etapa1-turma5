class Job < ApplicationRecord

  enum level: { junior: 0, full: 1 ,senior: 2}
end
