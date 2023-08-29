# frozen_string_literal: true

class SpecieSerializer < ActiveModel::Serializer
  attributes :id, :scientific_name, :scientific_name_id, :kingdom, :phylum, :specie_class,
             :order, :family, :genus, :scientific_name_authorship, :fid
end
