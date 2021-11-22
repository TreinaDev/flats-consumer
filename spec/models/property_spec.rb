require 'rails_helper'

describe Property, type: :model do
  context '.all' do
    it 'should return an array' do
      api_response = File.read(Rails.root.join("spec/support/apis/property_index.json"))
      fake_response = double('faraday_response', status: 200, body: api_response)
      
      allow(Faraday).to receive(:get).with("http://localhost:3000/api/v1/properties/")
                        .and_return(fake_response)

      result = Property.all

      expect(result.length).to eq 2
      expect(result[0].title).to eq "Apartamento legal"
      expect(result[0].description).to eq "Lindo apartamento no Leme"
      expect(result[1].title).to eq "Apartamento antigo"
      expect(result[1].description).to eq "Apartamento decorado com vista para o forte de Copacabana"
    end

    it 'should return nil if error' do
      fake_response = double('faraday_response', status: 500, body: "")
      allow(Faraday).to receive(:get).with("http://localhost:3000/api/v1/properties/")
                                     .and_return(fake_response)

      result = Property.all

      expect(result).to eq nil
    end
  end
end