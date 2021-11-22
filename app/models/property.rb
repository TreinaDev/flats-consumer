class Property
  attr_accessor :title, :description
  
  def initialize(params)
    @title = params[:title]
    @description = params[:description]
  end

  def self.all
    result = []
    response = Faraday.get("http://localhost:3000/api/v1/properties/")
    return nil if response.status == 500
    if response.status == 200
      data = JSON.parse(response.body, symbolize_names: true)
      data.each do |d|
        result << Property.new(d)
      end
    end
    result
  end
end