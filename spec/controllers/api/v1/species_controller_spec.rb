# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::SpeciesController, type: :controller do
  describe 'GET #map' do
    context 'when we have occurrences' do
      before do
        create :occurrence, :with_species
      end

      it 'generates correct geojson for map' do
        get :map, format: :json
        expected_result = { 'type' => 'FeatureCollection',
                            'features' =>
          [{ 'type' => 'Feature',
             'geometry' => { 'type' => 'Point', 'coordinates' => [178.26435, -19.121717] },
             'properties' =>
          { 'id' => 1,
            'scientificNameID' => 'urn:lsid:marinespecies.org:taxname:213686_1',
            'scientificName' => 'Neurymenia fraxinifolia_1',
            'kingdom' => 'Plantae_1',
            'phylum' => 'Rhodophyta_1',
            'class' => 'Florideophyceae_1',
            'order_' => 'Ceramiales_1',
            'family' => 'Rhodomelaceae_1',
            'genus' => 'Neurymenia_1',
            'scientificNameAuthorship' => '(Mertens ex Turner) J.Agardh, 1863_1',
            'FID' => '1096_1' },
             'id' => 1 },
           { 'type' => 'Feature',
             'geometry' => { 'type' => 'Point', 'coordinates' => [178.26435, -19.121717] },
             'properties' =>
           { 'id' => 2,
             'scientificNameID' => 'urn:lsid:marinespecies.org:taxname:213686_2',
             'scientificName' => 'Neurymenia fraxinifolia_2',
             'kingdom' => 'Plantae_2',
             'phylum' => 'Rhodophyta_2',
             'class' => 'Florideophyceae_2',
             'order_' => 'Ceramiales_2',
             'family' => 'Rhodomelaceae_2',
             'genus' => 'Neurymenia_2',
             'scientificNameAuthorship' => '(Mertens ex Turner) J.Agardh, 1863_2',
             'FID' => '1096_2' },
             'id' => 2 },
           { 'type' => 'Feature',
             'geometry' => { 'type' => 'Point', 'coordinates' => [178.26435, -19.121717] },
             'properties' =>
           { 'id' => 3,
             'scientificNameID' => 'urn:lsid:marinespecies.org:taxname:213686_3',
             'scientificName' => 'Neurymenia fraxinifolia_3',
             'kingdom' => 'Plantae_3',
             'phylum' => 'Rhodophyta_3',
             'class' => 'Florideophyceae_3',
             'order_' => 'Ceramiales_3',
             'family' => 'Rhodomelaceae_3',
             'genus' => 'Neurymenia_3',
             'scientificNameAuthorship' => '(Mertens ex Turner) J.Agardh, 1863_3',
             'FID' => '1096_3' },
             'id' => 3 },
           { 'type' => 'Feature',
             'geometry' => { 'type' => 'Point', 'coordinates' => [178.26435, -19.121717] },
             'properties' =>
           { 'id' => 4,
             'scientificNameID' => 'urn:lsid:marinespecies.org:taxname:213686_4',
             'scientificName' => 'Neurymenia fraxinifolia_4',
             'kingdom' => 'Plantae_4',
             'phylum' => 'Rhodophyta_4',
             'class' => 'Florideophyceae_4',
             'order_' => 'Ceramiales_4',
             'family' => 'Rhodomelaceae_4',
             'genus' => 'Neurymenia_4',
             'scientificNameAuthorship' => '(Mertens ex Turner) J.Agardh, 1863_4',
             'FID' => '1096_4' },
             'id' => 4 },
           { 'type' => 'Feature',
             'geometry' => { 'type' => 'Point', 'coordinates' => [178.26435, -19.121717] },
             'properties' =>
           { 'id' => 5,
             'scientificNameID' => 'urn:lsid:marinespecies.org:taxname:213686_5',
             'scientificName' => 'Neurymenia fraxinifolia_5',
             'kingdom' => 'Plantae_5',
             'phylum' => 'Rhodophyta_5',
             'class' => 'Florideophyceae_5',
             'order_' => 'Ceramiales_5',
             'family' => 'Rhodomelaceae_5',
             'genus' => 'Neurymenia_5',
             'scientificNameAuthorship' => '(Mertens ex Turner) J.Agardh, 1863_5',
             'FID' => '1096_5' },
             'id' => 5 }] }
        result = JSON.parse(response.body)['occurrences']
        expect(result).to eql(expected_result)
      end

      it 'returns code 200' do
        get :map, format: :json
        code = JSON.parse(response.body)['code']
        expect(code).to eq 200
        expect(response.code).to eq '200'
      end
    end

    context 'when we dont have occurrences' do
      it 'returns blank geojson array' do
        get :map, format: :json
        expected_result = { 'features' => [], 'type' => 'FeatureCollection' }
        result = JSON.parse(response.body)['occurrences']
        expect(result).to eql(expected_result)
      end

      it 'returns code 200' do
        get :map, format: :json
        code = JSON.parse(response.body)['code']
        expect(code).to eq 200
        expect(response.code).to eq '200'
      end
    end
  end
end
