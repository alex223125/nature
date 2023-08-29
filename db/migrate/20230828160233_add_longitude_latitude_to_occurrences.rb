# frozen_string_literal: true

class AddLongitudeLatitudeToOccurrences < ActiveRecord::Migration[7.0]
  def change
    add_column :occurrences, :longitude, :string
    add_column :occurrences, :latitude, :string
    add_index :occurrences, %i[longitude latitude], unique: true
  end
end
