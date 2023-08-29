# frozen_string_literal: true

class AddScientificNameIdIndexToSpecies < ActiveRecord::Migration[7.0]
  def change
    add_index :species, :scientific_name_id, unique: true
  end
end
