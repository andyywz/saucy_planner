class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :date
      t.datetime :end_date
      t.references :user_id, foreign_key: true
      t.text :description

      t.timestamps
    end
  end
end
