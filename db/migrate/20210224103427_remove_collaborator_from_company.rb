class RemoveCollaboratorFromCompany < ActiveRecord::Migration[6.1]
  def change
    remove_reference :companies, :collaborator, null: false, foreign_key: true
  end
end
