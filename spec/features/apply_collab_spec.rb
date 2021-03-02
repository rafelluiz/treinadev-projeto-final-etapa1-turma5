require 'rails_helper'

feature 'Application collaborator ' do
  scenario 'views candidates ' do
    collaborator_example = Collaborator.create!(email:'email@example.com',password: '123456')
    Company.find(collaborator_example.company.id).update!(email:'contact@example.com')
    job_program = Job.create!(title: 'Programador',description: 'Estamos a procura de um profissional...',
                              starting_salary_range: 1000,final_salary_range:2000,level:'junior',
                              requirements: 'Experiência de 2 anos na função',expiration_date:'23/11/2021',
                              total_job: 4,company:collaborator_example.company)
    candidate = Candidate.create!(email:'candidate@gmail.com', password:'123456', full_name:'Fulano de Tal',
                                  social_name:'Fulano', cpf:'111.111.111-11', telephone:'3197861234',
                                  biography:'Conclui bacharel em sistemas de ....')

    login_as collaborator_example, scope: :collaborator
    visit root_path
    visit current_path #Não estava encontrando o link 'Candidaturas', fiz um "refresh"(não sei se é a melhor solução)
    click_on 'Candidaturas'
    click_on candidate.full_name

    expect(current_path).to eq candidate_path(candidate)
    expect(page).to have_content 'candidate@gmail.com'
    expect(page).to have_content 'Fulano de Tal'
    expect(page).to have_content 'Programador'


  end
end
