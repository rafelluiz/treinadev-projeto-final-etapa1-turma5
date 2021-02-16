require 'rails_helper'

feature 'Collaborator register a job' do
  scenario 'successfully' do
    visit root_path
    click_on 'Vagas'
    click_on 'Registrar uma vaga'

    fill_in 'Título', with: 'Programador Delphi'
    fill_in 'Descrição', with: 'Estamos a procura de um profissional...'
    fill_in 'Faixa Salarial', with: '1000'
    fill_in 'Nível', with: 'júnior'
    fill_in 'Quantidade de cupons', with: '90'
    fill_in 'Data de término', with: '22/12/2033'
  end
end