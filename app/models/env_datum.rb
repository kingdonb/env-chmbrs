class EnvDatum < ApplicationRecord
  belongs_to :thing
  scope :older_than_two_weeks, -> { where("created_at < ?", 2.weeks.ago) }
end
