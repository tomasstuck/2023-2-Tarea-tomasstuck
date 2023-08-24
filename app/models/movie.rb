class Movie < ApplicationRecord
  belongs_to :director
  # no puede tener atributos nulos ni vacíos
  validates :title, presence: true, allow_blank: false
  validates :title, uniqueness: true
  validates :sinopsis, presence: true, allow_blank: false
  validates :duration, presence: true, allow_blank: false
  validates :duration, numericality: { only_integer: true }
  validates :premiere, presence: true, allow_blank: false
end
