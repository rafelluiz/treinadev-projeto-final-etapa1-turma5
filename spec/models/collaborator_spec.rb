require 'rails_helper'

describe Collaborator do
  context 'validation' do
    it 'successfully' do
      collaborator = Collaborator.create(email: 'admin@user.com',password: 'password')

      expect(collaborator.valid?).to eq true
    end
    it 'attributes cannot be blank' do
      collaborator = Collaborator.new

      expect(collaborator.valid?).to eq false
      expect(collaborator.errors.count).to eq 3
    end
  end

  context '.is_company' do
    it 'check if the email is not corporate' do
      collaborator = Collaborator.create(email: 'admin@gmail.com',password: 'password')
      error = collaborator.errors.full_messages.join(', ')
      expect(collaborator.valid?).to eq false
      expect(error).to include 'deve conter domínio empresarial.'
    end

  end
  context '#create_company' do
    it 'automatically generate company' do
      collaborator_admin = Collaborator.create(email: 'admin@example.com',password: 'password')
      collaborator_user = Collaborator.create(email: 'user@example.com',password: 'password')

      expect(Company.count).to eq 1
      expect(Collaborator.count).to eq 2
      expect(collaborator_admin.reload.admin?).to eq true
      expect(collaborator_user.reload.admin?).to eq false
    end

    it 'with several companies and collaborators' do
      collaborator_admin_example = Collaborator.create(email: 'admin@example.com',password: 'password')
      collaborator_user_example = Collaborator.create(email: 'user@example.com',password: 'password')

      collaborator_admin_other = Collaborator.create(email: 'admin@other.com',password: 'password')
      collaborator_user_other = Collaborator.create(email: 'user@other.com',password: 'password')

      company_example = Company.find_by(email_domain:'example.com')
      company_other = Company.find_by(email_domain:'other.com')

      expect(Company.count).to eq 2
      expect(Collaborator.count).to eq 4
      expect(company_example.id).to eq collaborator_admin_example.company_id
      expect(company_example.id).to eq collaborator_user_example.company_id
      expect(company_other.id).to eq collaborator_admin_other.company_id
      expect(company_other.id).to eq collaborator_user_other.company_id

    end
  end

end
