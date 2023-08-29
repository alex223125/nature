# frozen_string_literal: true

# id: 31,
#   created_at: Mon, 28 Aug 2023 18:37:59.603016000 UTC +00:00,
#   updated_at: Mon, 28 Aug 2023 18:37:59.603016000 UTC +00:00,
#   lonlat: #<RGeo::Geographic::SphericalPointImpl:0x4b64 "POINT (178.26435 -19.121717)">,
#   longitude: "178.26435",
#   latitude: "-19.121717">

FactoryBot.define do
  factory :occurrence, class: 'Occurrence' do
    longitude { '178.26435' }
    latitude { '-19.121717' }
    lonlat { RGeo::Cartesian.factory(srid: 4326).point(178.26435, -19.121717) }
  end

  trait :with_species do
    before(:create) do |occurrence|
      # create(:specie, occurrence: [occurrence])
      create_list(:specie, 5, occurrences: [occurrence])
    end
  end
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
