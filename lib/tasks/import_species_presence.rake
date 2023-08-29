desc "Imports a CSV file with locations into an ApplicationRecord table"
task :import_species_presence => [:environment] do
  path = "lib/data/Survey_of_algae,_sponges,_and_ascidians,_Fiji,_2007.csv"
  service = Services::DataImport::SpeciesPresence.new(path)
  service.call
end