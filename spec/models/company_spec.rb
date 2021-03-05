require 'rails_helper'

describe Company do

  context 'validation' do
    it 'attributes cannot be blank' do
      company = Company.new

      expect(company.valid?).to eq false
      expect(company.errors.count).to eq 3
    end
  end
end
