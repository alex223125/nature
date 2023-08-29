# frozen_string_literal: true

# #<Specie:0x00007f054857cae8
# id: 313,
#   scientific_name: "Neurymenia fraxinifolia",
#   scientific_name_id: "urn:lsid:marinespecies.org:taxname:213686",
#   kingdom: "Plantae",
#   phylum: "Rhodophyta",
#   specie_class: "Florideophyceae",
#   order: "Ceramiales",
#   family: "Rhodomelaceae",
#   genus: "Neurymenia",
#   scientific_name_authorship: "(Mertens ex Turner) J.Agardh, 1863",
#   fid: "1096",
#   created_at: Mon, 28 Aug 2023 18:37:59.702285000 UTC +00:00,
#   updated_at: Mon, 28 Aug 2023 18:37:59.702285000 UTC +00:00>

# sequence(:login) { |n| "test_login_#{n}" }

FactoryBot.define do
  factory :specie, class: 'Specie' do
    sequence(:scientific_name) { |n| "Neurymenia fraxinifolia_#{n}" }
    sequence(:scientific_name_id) { |n| "urn:lsid:marinespecies.org:taxname:213686_#{n}" }
    sequence(:kingdom) { |n| "Plantae_#{n}" }
    sequence(:phylum) { |n| "Rhodophyta_#{n}" }
    sequence(:specie_class) { |n| "Florideophyceae_#{n}" }
    sequence(:order) { |n| "Ceramiales_#{n}" }
    sequence(:family) { |n| "Rhodomelaceae_#{n}" }
    sequence(:genus) { |n| "Neurymenia_#{n}" }
    sequence(:scientific_name_authorship) { |n| "(Mertens ex Turner) J.Agardh, 1863_#{n}" }
    sequence(:fid) { |n| "1096_#{n}" }
  end

  # trait :with_species do
  #   before(:create) do |occurrence|
  #     create(:specie, occurrence: [occurrence])
  #   end
  # end
  #
  # trait :with_user_statistics do
  #   before(:create) do |post|
  #     create(:user, posts: [post])
  #     create(:statistics, post: post)
  #   end
  # end
  #
  # trait :with_user_statistics_evaluations do
  #   before(:create) do |post|
  #     create(:user, posts: [post])
  #     create(:evaluation, post: post)
  #   end
  # end
  #
  # trait :with_user_statistics_evaluations_ratings do
  #   before(:create) do |post, evaluator|
  #     create(:user, posts: [post])
  #     create(:evaluation, post: post, created_at: evaluator.created_at) do |evaluation|
  #       create(:statistics, :with_rating, post: post, evaluation: evaluation)
  #     end
  #   end
  # end
end
