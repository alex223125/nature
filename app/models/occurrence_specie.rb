# frozen_string_literal: true

class OccurrenceSpecie < ApplicationRecord
  belongs_to :occurrence, class_name: 'Occurrence'
  belongs_to :specie, class_name: 'Specie'
end
