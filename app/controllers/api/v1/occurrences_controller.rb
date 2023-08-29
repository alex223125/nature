# frozen_string_literal: true

module Api
  module V1
    class OccurrencesController < ApplicationController
      before_action :set_occurrence, only: %i[presence]

      def presence
        if @occurrence.present?
          @species = @occurrence.species
          serialized = ActiveModel::Serializer::ArraySerializer.new(@species, each_serializer: SpecieSerializer)
          render json: { code: 200, species: serialized }
        else
          render json: { code: 200, species: [] }
        end
      end

      private

      def presence_params
        params.require(:presence).permit(:latitude, :longitude)
      end

      def set_occurrence
        latitude = params[:presence][:latitude]
        longitude = params[:presence][:longitude]
        @occurrence = Occurrence.where(lonlat: "POINT(#{longitude.to_f} #{latitude.to_f})").first
      end
    end
  end
end
