# frozen_string_literal: true

desc 'Imports a CSV file with locations into an ApplicationRecord table'
task import_species_presence: [:environment] do
  path = 'lib/data/Survey_of_algae_2C_sponges_2C_and_ascidians_2C_Fiji_2C_2007.csv'
  service = Services::DataImport::SpeciesPresence.new(path)
  service.call
end
