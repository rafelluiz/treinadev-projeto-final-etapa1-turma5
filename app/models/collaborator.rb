class Collaborator < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :company
  validate :is_company?

  before_validation :register_company

  private
  def register_company

    domain_company = email.split('@')[1]
    company_name = domain_company.split('.')[0]
    company = Company.where(email_domain: domain_company)

    if company.count.zero?
      company_created = Company.create!(name: company_name,
                                        email_domain: domain_company)

      self.company = company_created
      self.admin = true
    else
      self.company_id = company.first.id
    end
  end

  def is_company?
    public_provider_email = %w[gmail hotmail yahoo aol terra outlook zoho mail protonmail icloud gmx uol]

    domain = email.split('@')[1].split('.')[0]

    errors.add(email,' deve conter domínio empresarial.') if public_provider_email.include?(domain)

  end
end
