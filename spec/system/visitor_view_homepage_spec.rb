require 'rails_helper'

describe 'Visitor visit home page' do
  context 'API' do
    it 'should view all properties' do
      properties = []
      properties << Property.new({ title: "Apartamento legal" })
      properties << Property.new({ title: "Apartamento antigo" })
      allow(Property).to receive(:all).and_return(properties)

      visit root_path

      expect(page).to have_content("Imóveis disponíveis via API")
      expect(page).to have_content("Apartamento legal")
      expect(page).to have_content("Apartamento antigo")
    end

    it 'should view error message' do
      allow(Property).to receive(:all).and_return(nil)

      visit root_path

      expect(page).to have_content("Não foi possível consultar os imóveis no momento")
    end
  end
end