class AddMessageSalaryProposalStartDateToApply < ActiveRecord::Migration[6.1]
  def change
    add_column :applies, :message, :text
    add_column :applies, :salary_proposal, :decimal
    add_column :applies, :start_date, :date
  end
end
