# frozen_string_literal: true

class Occurrence < ApplicationRecord
  has_many :occurrence_species, dependent: :destroy, class_name: 'OccurrenceSpecie'
  has_many :species, through: :occurrence_species, source: :specie

  validates :longitude, uniqueness: { scope: :latitude }
end
