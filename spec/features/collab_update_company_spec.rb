require 'rails_helper'

feature 'Collaborator update company' do
  scenario 'update company' do
    collaborator = Collaborator.create!(email: 'email_domain@example.com',password: 'password')

    login_as collaborator, scope: :collaborator

    visit root_path
    click_on 'Concluir Cadastro'

    fill_in 'Nome', with: 'algorithm me'
    attach_file 'Logomarca', Rails.root.join('spec', 'support', 'logo.jpg')
    fill_in 'Endereço', with: 'Rua das flores, Numero 0'
    fill_in 'Site', with: 'www.algorithm.com'
    fill_in 'Twitter', with: 'http://twitter.com/algorithm'
    fill_in 'Facebook', with: 'http://facebook.com/algorithm'
    fill_in 'Instagram', with: 'http://instagram.com/algorithm'
    fill_in 'LinkedIn', with: 'http://linkedin.com/algorithm'
    fill_in 'E-Mail',with: 'algorithm@algorithm.com'

    click_on 'Enviar'

    company = Company.last

    expect(company.registration_completed).to eq true
    expect(current_path).to eq company_path(company)
    expect(page).not_to have_content 'Conclua o Cadastro da Empresa. Só assim poderá cadastrar vagas.'
    expect(page).to have_content 'Company was successfully updated.'
    expect(page).to have_content 'algorithm me'
    expect(page).to have_content 'Rua das flores, Numero 0'
    expect(page).to have_content 'www.algorithm.com'
    expect(page).to have_content 'http://twitter.com/algorithm'
    expect(page).to have_content 'http://facebook.com/algorithm'
    expect(page).to have_content 'http://instagram.com/algorithm'
    expect(page).to have_content 'http://linkedin.com/algorithm'
    expect(page).to have_content 'algorithm@algorithm.com'
    expect(page).to have_css('img[src*="logo.jpg"]')
  end
end
