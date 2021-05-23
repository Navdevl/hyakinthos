class CreateMatchRules < ActiveRecord::Migration[6.0]
  def change
    create_table :match_rules do |t|
      t.integer :rule_type
      t.string :match_string
      t.string :clean_match_string
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end
  end
end
