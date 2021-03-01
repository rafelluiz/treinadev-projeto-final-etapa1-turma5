require 'rails_helper'

feature 'Candidate Access' do
  scenario 'and sign-up ' do
    visit root_path
    click_on 'Candidato'
    click_on 'Inscrever-se'
    within('form') do
      fill_in 'E-mail',with: 'fulano@example.com'
      fill_in 'Senha',with: 'password'
      fill_in 'Confirme sua senha',with: 'password'
      fill_in 'Nome Completo',with: 'Fulano de Tal'
      fill_in 'Nome Social',with: 'Fulano'
      fill_in 'CPF',with: '111.111.111-11'
      fill_in 'Telefone',with: '88-8878-5897'
      fill_in 'Biografia',with: 'Conclui bacharel ...'
      click_on 'Inscrever-se'
    end

    candidate = Candidate.last

    expect(page).not_to have_content 'Não foi possível salvar candidato'
    expect(page).to have_content 'Bem vindo! Você realizou seu registro com sucesso.'
    expect(candidate.full_name).to eq 'Fulano de Tal'

  end
end
