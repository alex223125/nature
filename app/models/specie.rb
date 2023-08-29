# frozen_string_literal: true

class Specie < ApplicationRecord
  has_many :occurrence_species, dependent: :destroy, class_name: 'OccurrenceSpecie'
  has_many :occurrences, through: :occurrence_species, source: :occurrence

  validates :scientific_name_id, uniqueness: true
end
