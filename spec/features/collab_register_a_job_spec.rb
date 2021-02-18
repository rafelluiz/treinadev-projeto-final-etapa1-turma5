require 'rails_helper'

feature 'Collaborator register a job' do
  scenario 'successfully' do
    visit root_path
    click_on 'Vagas'
    click_on 'Registrar uma vaga'

    fill_in 'Título', with: 'Programador Delphi'
    fill_in 'Descrição', with: 'Estamos a procura de um profissional...'
    fill_in 'Faixa Salarial Inicial', with: '1000'
    fill_in 'Faixa Salarial Final', with: '2308'
    select  'junior', from: 'Nível'
    fill_in 'Requisitos', with: 'Experiência de 2 anos na função'
    fill_in 'Expira em', with: '22/12/2021'
    fill_in 'Quantidade de Vaga', with: '3'

    click_on 'Criar Vaga'

    job = Job.last

    expect(current_path).to eq(job_path(job))
    expect(page).to have_content('Programador Delphi')
    expect(page).to have_content('Estamos a procura de um profissional...')
    expect(page).to have_content('De R$ 1.000,00 a R$ 2.308,00')
    expect(page).to have_content('junior')
    expect(page).to have_content('Experiência de 2 anos na função')
    expect(page).to have_content('22/12/2021')
    expect(page).to have_content('3')
  end
end