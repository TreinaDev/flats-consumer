class Property
  attr_accessor :title, :description, :property_type

  def initialize(hash_parameters)
    @title = hash_parameters[:title]
    @description = hash_parameters[:description]
  end


  def self.all
    imoveis = []
    response = Faraday.get("http://localhost:3000/api/v1/properties/")

    if response.status == 200
      data = JSON.parse(response.body)
      data.each do |d|
        imoveis << Property.new({ title: d["title"], description: d["description"] })
      end
    end

    return imoveis
  end


  def self.find(id)
    imovel = nil
    response = Faraday.get("http://localhost:3000/api/v1/properties/#{id}")
    return nil if response.status == 404
    if response.status == 200
      data = JSON.parse(response.body)
      imovel = Property.new({ title: data["title"], description: data["description"] })
    end
    return imovel
  end
end