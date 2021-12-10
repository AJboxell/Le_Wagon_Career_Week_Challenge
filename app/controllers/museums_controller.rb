class MuseumsController < ApplicationController

  def show
    @postcodes = Museum.all.group_by { |museum| museum.postcode }
  end

  def search
    Museum.destroy_all
    lat = params["museums_search_path"]["lat"]
    lon = params["museums_search_path"]["lon"]
    url = "https://api.mapbox.com/geocoding/v5/mapbox.places/museum.json?limit=10&proximity=#{lon.to_f}%2C#{lat.to_f}&types=poi&access_token=pk.eyJ1IjoiYWpib3hlbGwiLCJhIjoiY2t2Y2FzZHZiMDNzbDMwbjNxc3M0N3hkMSJ9.1xPb_bMld-VYiN0euzA8iA"
    user_serialized = URI.open(url).read
    @museums = JSON.parse(user_serialized)
    @museums["features"].each do |item|
      museum = Museum.new(name: item["place_name"], postcode: item["context"][0]["text"])
      museum.save!
    end
    redirect_to museums_path
  end
end
