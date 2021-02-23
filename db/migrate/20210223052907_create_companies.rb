class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.text :address
      t.string :site
      t.string :twitter
      t.string :facebook
      t.string :instagram
      t.string :linkedin
      t.string :email_domain
      t.boolean :registration_completed
      t.references :collaborator, null: false, foreign_key: true

      t.timestamps
    end
  end
end
