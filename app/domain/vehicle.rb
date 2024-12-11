class Vehicle < ActiveRecord::Base
  self.table_name = 'vehicles'
  validates :brand, :model, :year, :price, presence: true
  validates :image_url, presence: false  # Asegúrate de que sea opcional
end