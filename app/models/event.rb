class Event < ApplicationRecord

  CATEGORİES = ["Arte", "Cultura", "Esporte", "Natureza", "Dança", "Gastronomia", "Política"]
  CONFİRMATİON_DEADLİNES = ["No dia do evento", "1 dia antes", "3 dias antes", "1 semana antes"]
  belongs_to :user

  validates :title, :description, :category, :date, :time, presence: true
end
