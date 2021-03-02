require 'rails_helper'

feature 'Candidate ' do
  scenario 'and sees vacancies ' do
    collaborator_example = Collaborator.create!(email:'email@example.com',password: 'password')

    job_program = Job.create!(title: 'Programador',description: 'Estamos a procura de um profissional...',
                              starting_salary_range: 1000,final_salary_range:2000,level:'junior',
                              requirements: 'Experiência de 2 anos na função',expiration_date:'23/11/2021',
                              total_job: 4,company:collaborator_example.company)

    job_ruby = Job.create!(title: 'Programador Ruby',description: 'Estamos a procura de um profissional...',
                           starting_salary_range: 1000,final_salary_range:2000,level:'full',
                           requirements: 'Experiência de 5 anos na função',expiration_date:'02/12/2021',
                           total_job: 4,company:collaborator_example.company)

    job_c = Job.create!(title: 'Programador C',description: 'Estamos a procura de um profissional...',
                        starting_salary_range: 1000,final_salary_range:2000,level:'full',
                        requirements: 'Experiência de 5 anos na função',expiration_date:'05/01/2023',
                        total_job: 4,company:collaborator_example.company)

    job_c.disabled!

    Company.find(collaborator_example.company.id).update(email:'contact@example.com')

    visit root_path
    click_on 'Vagas'
    click_on 'example'
    expect(page).to have_content 'Programador'
    expect(page).to have_content 'Programador Ruby'
    expect(page).not_to have_content 'Programador C'
  end

  scenario 'and search for job ' do
    collaborator_example = Collaborator.create!(email:'email@example.com',password: 'password')

    job_program = Job.create!(title: 'Programador',description: 'Estamos a procura de um profissional...',
                              starting_salary_range: 1000,final_salary_range:2000,level:'junior',
                              requirements: 'Experiência de 2 anos na função',expiration_date:'23/11/2021',
                              total_job: 4,company:collaborator_example.company)
    job_ruby = Job.create!(title: 'Programador Ruby',description: 'Estamos a procura de um profissional...',
                           starting_salary_range: 1000,final_salary_range:2000,level:'full',
                           requirements: 'Experiência de 5 anos na função',expiration_date:'02/12/2021',
                           total_job: 4,company:collaborator_example.company)
    job_ruby.disabled!
    Company.find(collaborator_example.company.id).update(email:'contact@example.com')

    visit root_path
    click_on 'Vagas'
    fill_in 'Busca:', with: 'Programador'
    click_on 'Pesquisar'

    expect(current_path).to eq jobs_path
    expect(page).to have_content 'Programador'
    expect(page).not_to have_content 'Programador Ruby'
  end

  scenario 'and search for company ' do
    collaborator_example = Collaborator.create!(email:'email@example.com',password: 'password')
    collaborator_miyazaki = Collaborator.create!(email:'email@miyazaki.com',password: 'password')

    job_program = Job.create!(title: 'Programador C#',description: 'Estamos a procura de um profissional...',
                              starting_salary_range: 1000,final_salary_range:2000,level:'junior',
                              requirements: 'Experiência de 2 anos na função',expiration_date:'23/11/2021',
                              total_job: 4,company:collaborator_example.company)
    job_ruby = Job.create!(title: 'Programador Ruby',description: 'Estamos a procura de um profissional...',
                           starting_salary_range: 1000,final_salary_range:2000,level:'full',
                           requirements: 'Experiência de 5 anos na função',expiration_date:'02/12/2021',
                           total_job: 4,company:collaborator_miyazaki.company)

    Company.find(collaborator_example.company.id).update(email:'contact@example.com')
    Company.find(collaborator_miyazaki.company.id).update(email:'contact@miyazaki.com')

    visit root_path
    click_on 'Vagas'
    fill_in 'Busca:', with: 'miyazaki'
    click_on 'Pesquisar'

    expect(current_path).to eq jobs_path
    expect(page).not_to have_content 'Programador C#'
    expect(page).to have_content 'Programador Ruby'
  end

  scenario 'and apply for a position' do
    collaborator_example = Collaborator.create!(email:'email@example.com',password: '123456')
    job_program = Job.create!(title: 'Programador C#',description: 'Estamos a procura de um profissional...',
                              starting_salary_range: 1000,final_salary_range:2000,level:'junior',
                              requirements: 'Experiência de 2 anos na função',expiration_date:'23/11/2021',
                              total_job: 25,company:collaborator_example.company)
    Company.find(collaborator_example.company.id).update(email:'contact@example.com')
    candidate = Candidate.create!(email:'candidate@gmail.com', password:'123456', full_name:'Fulano de Tal',
                                  social_name:'Fulano', cpf:'111.111.111-11', telephone:'3197861234',
                                  biography:'Conclui bacharel em sistemas de ....')

    login_as candidate, scope: :candidate

    visit root_path
    click_on 'Vagas'
    click_on 'example'
    click_on 'Candidatar'

    applies = job_program.candidates.map(&:email)

    expect(current_path).to eq jobs_path
    expect(applies).to include 'candidate@gmail.com'
    expect(page).to have_content 'Apply was successful'


  end
end
