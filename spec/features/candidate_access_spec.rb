require 'rails_helper'

feature 'Candidate Access' do
  scenario 'and sign-up ' do
    visit root_path
    click_on 'Candidato'
  end
end
