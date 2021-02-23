require 'rails_helper'

describe Collaborator do
  context '#create_company' do
    it 'automatically generate company' do
      Collaborator.create!(email: 'admin@example.com',password: 'password')
      Collaborator.create!(email: 'user@example.com',password: 'password')

      expect(Company.count).to eq 1
      expect(Collaborator.count).to eq 2
    end
  end
end
