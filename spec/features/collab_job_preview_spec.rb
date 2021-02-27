require 'rails_helper'

feature 'Employee visualizes vacancies' do
  scenario 'company vacancies' do
    collaborator_example = Collaborator.create!(email:'email@example.com',password: 'password')
    collaborator_example_more = Collaborator.create!(email:'more@example.com',password: 'password')
    collaborator_other = Collaborator.create!(email:'email@other.com',password: 'password')

    job_program = Job.create!(title: 'Programador',description: 'Estamos a procura de um profissional...',
                              starting_salary_range: 1000,final_salary_range:2000,level:'junior',
                              requirements: 'Experiência de 2 anos na função',expiration_date:'23/11/2021',
                              total_job: 4,company:collaborator_example.company)

    job_ruby = Job.create!(title: 'Programador Ruby',description: 'Estamos a procura de um profissional...',
                           starting_salary_range: 1000,final_salary_range:2000,level:'full',
                           requirements: 'Experiência de 5 anos na função',expiration_date:'02/12/2021',
                           total_job: 4,company:collaborator_example_more.company)

    job_c = Job.create!(title: 'Programador C',description: 'Estamos a procura de um profissional...',
                           starting_salary_range: 1000,final_salary_range:2000,level:'full',
                           requirements: 'Experiência de 5 anos na função',expiration_date:'05/01/2023',
                           total_job: 4,company:collaborator_other.company)

    Company.find(collaborator_example.company.id).update(email:'contact@example.com')
    Company.find(collaborator_other.company.id).update(email:'contact@other.com')

    login_as collaborator_example, scope: :collaborator

    visit root_path
    click_on 'Vagas'
    expect(page).to have_content 'example'
    expect(page).to have_content 'Programador'
    expect(page).to have_content 'Programador Ruby'
    expect(page).to have_content '02/12/2021'
    expect(page).not_to have_content 'Programador C'
    expect(page).not_to have_content 'Conclua o Cadastro da Empresa. Só assim poderá cadastrar vagas.'
  end

  scenario 'view a specific vacancy' do
    collaborator_example = Collaborator.create!(email:'email@example.com',password: 'password')
    job_program = Job.create!(title: 'Programador',description: 'Estamos a procura de um profissional...',
                              starting_salary_range: 1000,final_salary_range:2000,level:'junior',
                              requirements: 'Experiência de 2 anos na função',expiration_date:'23/11/2021',
                              total_job: 4,company:collaborator_example.company)
    Company.find(collaborator_example.company.id).update(email:'contact@example.com')
    login_as collaborator_example, scope: :collaborator

    visit root_path
    click_on 'Vagas'
    click_on 'Exibir'

    expect(page).to have_content 'Programador'
    expect(page).to have_content 'Estamos a procura de um profissional...'
    expect(page).to have_content '23/11/2021'
    expect(page).to have_content 'junior'
  end


  scenario 'and edit job' do
    collaborator_example = Collaborator.create!(email:'email@example.com',password: 'password')
    job_program = Job.create!(title: 'Programador',description: 'Estamos a procura de um profissional...',
                              starting_salary_range: 1000,final_salary_range:2000,level:'junior',
                              requirements: 'Experiência de 2 anos na função',expiration_date:'23/11/2021',
                              total_job: 4,company:collaborator_example.company)
    Company.find(collaborator_example.company.id).update(email:'contact@example.com')
    login_as collaborator_example, scope: :collaborator

    visit root_path
    click_on 'Vagas'
    click_on 'Editar'

    fill_in 'Título', with: 'Programador Delphi'
    fill_in 'Descrição', with: 'Estamos contrantando urgente um profissional...'
    fill_in 'Faixa Salarial Inicial', with: '1000'
    fill_in 'Faixa Salarial Final', with: '2308'
    select  'senior', from: 'Nível'
    fill_in 'Requisitos', with: 'Experiência de 4 anos na função'
    fill_in 'Expira em', with: '22/12/2023'
    fill_in 'Quantidade de Vaga', with: '2'

    click_on 'Enviar'

    job = Job.last

    expect(current_path).to eq(job_path(job))
    expect(page).to have_content('Programador Delphi')
    expect(page).to have_content('Estamos contrantando urgente um profissional...')
    expect(page).to have_content('De R$ 1.000,00 a R$ 2.308,00')
    expect(page).to have_content('senior')
    expect(page).to have_content('Experiência de 4 anos na função')
    expect(page).to have_content('22/12/2023')
    expect(page).to have_content('2')
  end

  scenario 'and disable vacancy' do
    collaborator_example = Collaborator.create!(email:'email@example.com',password: 'password')
    job_program = Job.create!(title: 'Programador',description: 'Estamos a procura de um profissional...',
                              starting_salary_range: 1000,final_salary_range:2000,level:'junior',
                              requirements: 'Experiência de 2 anos na função',expiration_date:'23/11/2021',
                              total_job: 4,company:collaborator_example.company)
    Company.find(collaborator_example.company.id).update(email:'contact@example.com')
    login_as collaborator_example, scope: :collaborator

    visit root_path
    click_on 'Vagas'
    click_on 'Desabilitar'

    job = Job.last

    expect(current_path).to eq(job_path(job))
    expect(page).to have_content('Programador')
    expect(page).to have_content('Estamos a procura de um profissional...')
    expect(page).to have_content('De R$ 1.000,00 a R$ 2.000,00')
    expect(page).to have_content('junior')
    expect(page).to have_content('Experiência de 2 anos na função')
    expect(page).to have_content('23/11/2021')
    expect(page).to have_content('4')
    expect(page).to have_content('Desabilitada')
  end
end