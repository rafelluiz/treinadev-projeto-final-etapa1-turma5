require 'rails_helper'

describe Collaborator do
  context '#create_company' do
    it 'automatically generate company' do
      collaborator_admin = Collaborator.create!(email: 'admin@example.com',password: 'password')
      collaborator_user = Collaborator.create!(email: 'user@example.com',password: 'password')

      expect(Company.count).to eq 1
      expect(Collaborator.count).to eq 2
      expect(collaborator_admin.reload.admin?).to eq true
      expect(collaborator_user.reload.admin?).to eq false
    end
  end
end
