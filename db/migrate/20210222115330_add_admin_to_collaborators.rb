class AddAdminToCollaborators < ActiveRecord::Migration[6.1]
  def change
    add_column :collaborators, :admin, :boolean, default: false
  end
end
