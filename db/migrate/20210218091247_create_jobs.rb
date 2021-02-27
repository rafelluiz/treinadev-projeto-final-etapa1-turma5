class CreateJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.decimal :starting_salary_range
      t.decimal :final_salary_range
      t.integer :level, null: false
      t.text :requirements
      t.date :expiration_date
      t.integer :total_job

      t.timestamps
    end
  end
end
