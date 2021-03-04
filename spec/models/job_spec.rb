require 'rails_helper'

describe Job do
  context '#apply!' do
    it 'apply only once for the vacancy' do
      collaborator_example = Collaborator.create!(email:'email@example.com',password: '123456')
      Company.find(collaborator_example.company.id).update!(email:'contact@example.com')
      job_program = Job.create!(title: 'Programador',description: 'Estamos a procura de um profissional...',
                                starting_salary_range: 1000,final_salary_range:2000,level:'junior',
                                requirements: 'Experiência de 2 anos na função',expiration_date:'23/11/2021',
                                total_job: 4,company:collaborator_example.company)
      candidate = Candidate.create!(email:'candidate@gmail.com', password:'123456', full_name:'Fulano de Tal',
                                    social_name:'Fulano', cpf:'111.111.111-11', telephone:'3197861234',
                                    biography:'Conclui bacharel em sistemas de ....')
      job_program.apply!(candidate)
      job_program.apply!(candidate)

      p job_program.errors.full_messages.join(', ')
      expect(ApplyFor.count).to eq 1


    end
  end
end
