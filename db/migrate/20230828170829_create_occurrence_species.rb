# frozen_string_literal: true

class CreateOccurrenceSpecies < ActiveRecord::Migration[7.0]
  def change
    create_table :occurrence_species do |t|
      t.references :occurrence, null: false, foreign_key: true
      t.references :specie, null: false, foreign_key: true
      t.timestamps
    end
  end
end
