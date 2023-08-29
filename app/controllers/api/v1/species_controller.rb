# frozen_string_literal: true

module Api
  module V1
    class SpeciesController < ApiController
      def map
        @occurrences = Occurrence.all.includes(:species)
        service = Services::Species::MapGeoJSON.new(@occurrences)
        results = service.call
        render json: { code: 200, occurrences: results }
      end
    end
  end
end
