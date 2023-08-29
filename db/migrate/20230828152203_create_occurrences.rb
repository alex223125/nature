# frozen_string_literal: true

class CreateOccurrences < ActiveRecord::Migration[7.0]
  def change
    create_table :occurrences, &:timestamps
  end
end
