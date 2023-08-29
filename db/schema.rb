# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_08_28_171015) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "occurrence_species", force: :cascade do |t|
    t.bigint "occurrence_id", null: false
    t.bigint "specie_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["occurrence_id"], name: "index_occurrence_species_on_occurrence_id"
    t.index ["specie_id"], name: "index_occurrence_species_on_specie_id"
  end

  create_table "occurrences", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.geography "lonlat", limit: {:srid=>4326, :type=>"geometry", :geographic=>true}
    t.string "longitude"
    t.string "latitude"
    t.index ["longitude", "latitude"], name: "index_occurrences_on_longitude_and_latitude", unique: true
    t.index ["lonlat"], name: "index_occurrences_on_lonlat", using: :gist
  end

  create_table "species", force: :cascade do |t|
    t.string "scientific_name"
    t.string "scientific_name_id"
    t.string "kingdom"
    t.string "phylum"
    t.string "specie_class"
    t.string "order"
    t.string "family"
    t.string "genus"
    t.string "scientific_name_authorship"
    t.string "fid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["scientific_name_id"], name: "index_species_on_scientific_name_id", unique: true
  end

  add_foreign_key "occurrence_species", "occurrences"
  add_foreign_key "occurrence_species", "species", column: "specie_id"
end
