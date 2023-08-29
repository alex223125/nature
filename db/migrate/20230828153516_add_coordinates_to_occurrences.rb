# frozen_string_literal: true

class AddCoordinatesToOccurrences < ActiveRecord::Migration[7.0]
  def change
    add_column :occurrences, :lonlat, :geometry, geographic: true, srid: 4326
    add_index :occurrences, :lonlat, using: :gist
  end
end
