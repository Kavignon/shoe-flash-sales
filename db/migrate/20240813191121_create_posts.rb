# frozen_string_literal: true

# CreatePosts migration creates the posts table in the database.
#
# This migration defines the structure of the posts table, including
# columns such as title, body, and timestamps. It ensures that the
# posts table is created with the specified columns and constraints.
class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
