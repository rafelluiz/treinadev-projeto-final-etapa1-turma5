class CreateApplies < ActiveRecord::Migration[6.1]
  def change
    create_table :applies do |t|
      t.references :candidate, null: false, foreign_key: true
      t.references :job, null: false, foreign_key: true
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
