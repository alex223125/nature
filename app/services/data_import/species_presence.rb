# frozen_string_literal: true

require 'csv'
module Services
  module DataImport
    class SpeciesPresence
      def initialize(path)
        @path = path
      end

      def call
        ActiveRecord::Base.transaction do
          parse
        end
      rescue ActiveRecord::RecordInvalid => e
        errors = e.message
        Rails.logger.error(errors)
      end

      private

      def parse
        CSV.foreach(@path, headers: true) do |row|
          occurrence = define_occurrence(row)
          specie = define_specie(row)
          define_association(occurrence, specie)
        end
      end

      def define_occurrence(row)
        occurrence = Occurrence.find_by(latitude: row['decimalLatitude'],
                                        longitude: row['decimalLongitude'])
        occurrence = create_occurrence(row) if occurrence.blank?
        occurrence
      end

      def create_occurrence(row)
        point = RGeo::Cartesian.factory(srid: 4326).point(row['decimalLongitude'],
                                                          row['decimalLatitude'])
        Occurrence.create!(latitude: row['decimalLatitude'],
                           longitude: row['decimalLongitude'],
                           lonlat: point)
      end

      def define_specie(row)
        specie = Specie.find_by(scientific_name_id: row['scientificNameID'])
        specie = create_specie(row) if specie.blank?
        specie
      end

      def create_specie(row)
        Specie.create!(scientific_name: row['scientificName'],
                       scientific_name_id: row['scientificNameID'],
                       kingdom: row['kingdom'],
                       phylum: row['phylum'],
                       specie_class: row['class'],
                       order: row['order_'],
                       family: row['family'],
                       genus: row['genus'],
                       scientific_name_authorship: row['scientificNameAuthorship'],
                       fid: row['FID'])
      end

      def define_association(occurrence, specie)
        return if associated?(occurrence, specie)

        occurrence.species << specie
      end

      def associated?(occurrence, specie)
        occurrence.species.include?(specie)
      end
    end
  end
end
