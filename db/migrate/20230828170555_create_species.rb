# frozen_string_literal: true

class CreateSpecies < ActiveRecord::Migration[7.0]
  def change
    create_table :species do |t|
      t.string :scientific_name
      t.string :scientific_name_id
      t.string :kingdom
      t.string :phylum
      t.string :specie_class
      t.string :order
      t.string :family
      t.string :genus
      t.string :scientific_name_authorship
      t.string :fid

      t.timestamps
    end
  end
end
