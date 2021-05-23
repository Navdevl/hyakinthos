class CreateOrganizations < ActiveRecord::Migration[6.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.text :description
      t.string :domain
      t.string :logo_url
      t.integer :logo_source
      t.references :user, null: true, foreign_key: true

      t.timestamps
    end
  end
end
