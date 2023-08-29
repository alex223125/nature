# frozen_string_literal: true

module Services
  module Species
    class MapGeoJSON
      def initialize(occurrences)
        @occurrences = occurrences
      end

      def call
        features = create_features_collection
        create_features_geojson(features)
      end

      private

      def create_features_geojson(features)
        RGeo::GeoJSON.encode(RGeo::GeoJSON::FeatureCollection.new(features))
      end

      # rubocop:disable Metrics/MethodLength
      def create_features_collection
        index = 0
        features = []
        @occurrences.each do |occurrence|
          occurrence.species.each do |presence|
            feature_string = create_feature_string(index, occurrence, presence)
            index += 1
            feature_geojson = RGeo::GeoJSON.decode(feature_string)
            features << feature_geojson
          end
        end
        features
      end
      # rubocop:enable Metrics/MethodLength

      def create_feature_string(index, occurrence, presence)
        <<-HASH
               {"type":"Feature", "id":#{index + 1},
                "geometry":{"type":"Point","coordinates":[#{occurrence.lonlat.longitude},#{occurrence.lonlat.latitude}]},
                "properties":
                {"id": #{presence.id},
                "scientificNameID":"#{presence.scientific_name_id}",
                "scientificName":"#{presence.scientific_name}",
                "kingdom":"#{presence.kingdom}",
                "phylum":"#{presence.phylum}",
                "class":"#{presence.specie_class}",
                "order_":"#{presence.order}",
                "family":"#{presence.family}",
                "genus":"#{presence.genus}",
                "scientificNameAuthorship":"#{presence.scientific_name_authorship}",
                "FID": "#{presence.fid}"}
              }
        HASH
      end
    end
  end
end
