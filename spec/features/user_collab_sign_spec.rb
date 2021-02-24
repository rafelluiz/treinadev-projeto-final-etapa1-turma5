require 'rails_helper'

feature 'User sign up' do
  scenario 'successfully not Admin' do
    Collaborator.create!(email:'admin@example.com',password:'password')
    visit root_path
    click_on 'Colaborador'
    click_on 'Sign up'
    within('form') do
      fill_in 'E-mail',with: 'email@example.com'
      fill_in 'Senha',with: 'password'
      fill_in 'Confirme sua senha',with: 'password'
      click_on 'Inscrever-se'
    end

    expect(Collaborator.last.admin?).to eq false
    expect(page).to have_content 'Bem vindo! Você realizou seu registro com sucesso.'
    #expect(page).to have_content 'Sair'
  end

  scenario 'successfully Admin' do

    visit root_path

    click_on 'Colaborador'
    click_on 'Sign up'
    within('form') do
      fill_in 'E-mail',with: 'email@example.com'
      fill_in 'Senha',with: 'password'
      fill_in 'Confirme sua senha',with: 'password'
      click_on 'Inscrever-se'
    end

    company = Company.last

    expect(company.email_domain).to eq 'example.com'

  end
end
