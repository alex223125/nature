# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::OccurrencesController, type: :controller do
  describe 'GET #presence' do
    let(:occurrence) { create :occurrence, :with_species }

    context 'when we have occurrences' do
      let(:params) do
        { presence: { latitude: occurrence.latitude,
                      longitude: occurrence.longitude } }
      end

      before do
        post :presence, format: :json, params: params
      end

      it 'returns correct species by longlat' do
        expected_result = [{ 'id' => 1,
                             'scientific_name' => 'Neurymenia fraxinifolia_1',
                             'scientific_name_id' => 'urn:lsid:marinespecies.org:taxname:213686_1',
                             'kingdom' => 'Plantae_1',
                             'phylum' => 'Rhodophyta_1',
                             'specie_class' => 'Florideophyceae_1',
                             'order' => 'Ceramiales_1',
                             'family' => 'Rhodomelaceae_1',
                             'genus' => 'Neurymenia_1',
                             'scientific_name_authorship' => '(Mertens ex Turner) J.Agardh, 1863_1',
                             'fid' => '1096_1' },
                           { 'id' => 2,
                             'scientific_name' => 'Neurymenia fraxinifolia_2',
                             'scientific_name_id' => 'urn:lsid:marinespecies.org:taxname:213686_2',
                             'kingdom' => 'Plantae_2',
                             'phylum' => 'Rhodophyta_2',
                             'specie_class' => 'Florideophyceae_2',
                             'order' => 'Ceramiales_2',
                             'family' => 'Rhodomelaceae_2',
                             'genus' => 'Neurymenia_2',
                             'scientific_name_authorship' => '(Mertens ex Turner) J.Agardh, 1863_2',
                             'fid' => '1096_2' },
                           { 'id' => 3,
                             'scientific_name' => 'Neurymenia fraxinifolia_3',
                             'scientific_name_id' => 'urn:lsid:marinespecies.org:taxname:213686_3',
                             'kingdom' => 'Plantae_3',
                             'phylum' => 'Rhodophyta_3',
                             'specie_class' => 'Florideophyceae_3',
                             'order' => 'Ceramiales_3',
                             'family' => 'Rhodomelaceae_3',
                             'genus' => 'Neurymenia_3',
                             'scientific_name_authorship' => '(Mertens ex Turner) J.Agardh, 1863_3',
                             'fid' => '1096_3' },
                           { 'id' => 4,
                             'scientific_name' => 'Neurymenia fraxinifolia_4',
                             'scientific_name_id' => 'urn:lsid:marinespecies.org:taxname:213686_4',
                             'kingdom' => 'Plantae_4',
                             'phylum' => 'Rhodophyta_4',
                             'specie_class' => 'Florideophyceae_4',
                             'order' => 'Ceramiales_4',
                             'family' => 'Rhodomelaceae_4',
                             'genus' => 'Neurymenia_4',
                             'scientific_name_authorship' => '(Mertens ex Turner) J.Agardh, 1863_4',
                             'fid' => '1096_4' },
                           { 'id' => 5,
                             'scientific_name' => 'Neurymenia fraxinifolia_5',
                             'scientific_name_id' => 'urn:lsid:marinespecies.org:taxname:213686_5',
                             'kingdom' => 'Plantae_5',
                             'phylum' => 'Rhodophyta_5',
                             'specie_class' => 'Florideophyceae_5',
                             'order' => 'Ceramiales_5',
                             'family' => 'Rhodomelaceae_5',
                             'genus' => 'Neurymenia_5',
                             'scientific_name_authorship' => '(Mertens ex Turner) J.Agardh, 1863_5',
                             'fid' => '1096_5' }]
        result = JSON.parse(response.body)['species']
        expect(result).to eql(expected_result)
      end

      it 'returns code 200' do
        code = JSON.parse(response.body)['code']
        expect(code).to eq 200
        expect(response.code).to eq '200'
      end
    end

    context 'when we dont have occurrences' do
      let(:params) do
        { presence: { latitude: 16,
                      longitude: 17 } }
      end

      before do
        post :presence, format: :json, params: params
      end

      it 'returns blank array' do
        expected_result = []
        result = JSON.parse(response.body)['species']
        expect(result).to eql(expected_result)
      end

      it 'returns code 200' do
        code = JSON.parse(response.body)['code']
        expect(code).to eq 200
        expect(response.code).to eq '200'
      end
    end
  end
end
