class Director < ApplicationRecord
    has_many :movies, dependent: :destroy
    has_many :rankings, dependent: :destroy
    # no puede tener atributos nulos ni vacíos
    validates :name, presence: true, allow_blank: false
    validates :name, uniqueness: true
    validates :age, presence: true, allow_blank: false
    validates :age, numericality: { only_integer: true }
    validates :country, presence: true, allow_blank: false
    validates :has_oscars, inclusion: { in: [true, false] }
end
