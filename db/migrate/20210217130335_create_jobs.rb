class CreateJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.decimal :salary_range
      t.integer :level
      t.text :requirements
      t.date :expiration_date
      t.integer :total_job

      t.timestamps
    end
  end
end
