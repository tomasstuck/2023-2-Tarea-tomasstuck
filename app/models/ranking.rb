class Ranking < ApplicationRecord
  belongs_to :director

  validates :page, presence: true, allow_blank: false
  validates :page, inclusion: { in: ["imdb", "rotten_tomatoes", "metacritic"] }
  validates :min_score, presence: true, allow_blank: false
  validates :score, presence: true, allow_blank: false
  validates :max_score, presence: true, allow_blank: false
end
