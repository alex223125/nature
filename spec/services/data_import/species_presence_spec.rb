# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::DataImport::SpeciesPresence do
  describe '#call' do
    context 'when we have csv file' do
      let(:path) { './spec/test_files/occurrences_test.csv' }
      let(:service) { described_class.new(path) }

      before do
        service.call
      end

      it 'creates correct occurrence' do
        occurrence = Occurrence.all.first
        expected_occurrence_longitude = '179.73695'
        expected_occurrence_latitude = '-16.185317'
        expected_lonlat = 'POINT (179.73695 -16.185317)'

        expect(expected_occurrence_longitude).to eql(occurrence.attributes['longitude'])
        expect(expected_occurrence_latitude).to eql(occurrence.attributes['latitude'])
        expect(expected_lonlat).to eql(occurrence.attributes['lonlat'].to_s)
      end

      it 'creates correct specie' do
        specie = Specie.all.first
        expected_result =
          { 'scientific_name' => 'Jania adhaerens',
            'scientific_name_id' => 'urn:lsid:marinespecies.org:taxname:145123',
            'kingdom' => 'Plantae',
            'phylum' => 'Rhodophyta',
            'specie_class' => 'Florideophyceae',
            'order' => 'Corallinales',
            'family' => 'Corallinaceae',
            'genus' => 'Jania',
            'scientific_name_authorship' => 'J.V.Lamouroux, 1816',
            'fid' => '1' }

        result = specie.attributes.except('created_at', 'updated_at', 'id')
        expect(result).to eql(expected_result)
      end

      it 'makes association between accurrence and species' do
        occurrence = Occurrence.all.first
        specie = Specie.all.first
        expect(occurrence.species.first).to eql(specie)
        expect(specie.occurrences.first).to eql(occurrence)
      end
    end
  end
end
