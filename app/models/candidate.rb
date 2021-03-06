class Candidate < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_presence_of :full_name, :social_name, :cpf, :telephone, :biography

  has_many :apply_fors
  has_many :jobs, through: :apply_fors
end
