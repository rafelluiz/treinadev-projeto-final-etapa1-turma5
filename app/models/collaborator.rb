class Collaborator < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validate :is_company?

  private

  def is_company?
    public_provider_email = ['gmail','hotmail','yahoo']
    domain = email.split('@')[1].split('.')[0]

    if public_provider_email.include?(domain)
      errors.add(email,'E-mail deve conter domínio empresarial.')
    end

  end
end
