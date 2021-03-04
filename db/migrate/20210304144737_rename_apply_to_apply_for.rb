class RenameApplyToApplyFor < ActiveRecord::Migration[6.1]
  def change
    rename_table :applies, :apply_fors
  end
end
